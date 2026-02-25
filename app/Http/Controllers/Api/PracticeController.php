<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Practice;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class PracticeController extends Controller
{






  public function index(Request $request)
  {
    // Если передан user_id  показываем практики конкретного пользователя
    if ($request->has('user_id')) {
        $practices = Practice::where('user_id', $request->user_id)
            ->with('logs')
            ->get();
        return response()->json($practices);
    }
    
    // Иначе показываем практики текущего пользователя
    $practices = $request->user()->practices()->with('logs')->get();
    return response()->json($practices);
  }










    public function store(Request $request)
{
    $validated = $request->validate([
        'name' => 'required|string|max:100',
        'type' => 'required|string|max:50',
        'goal_value' => 'nullable|integer',
        'goal_unit' => 'nullable|string|max:20',
        'goal_days' => 'nullable|integer',
        'period_type' => 'nullable|string|max:20',
        'days_of_week' => 'nullable|array',
        'reminder_time' => 'nullable|date_format:H:i',
        'reminder_channels' => 'nullable|array',
        'privacy' => 'nullable|string|max:20',
        'is_active' => 'nullable|boolean',
        'is_binary' => 'nullable|boolean',
    ]);

     $validated['user_id'] = $request->user()->id;
    $practice = Practice::create($validated);

    return response()->json($practice, 201);
}

    public function show(Practice $practice)
    {
        return response()->json($practice->load('logs'));
    }

    public function update(Request $request, Practice $practice)
    {
        if ($request->user()->id !== $practice->user_id) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'name' => 'sometimes|string|max:100',
            'type' => 'sometimes|string|max:50',
            'goal_value' => 'nullable|integer',
            'goal_unit' => 'nullable|string|max:20',
            'goal_days' => 'nullable|integer',
            'period_type' => 'nullable|string|max:20',
            'days_of_week' => 'nullable|array',
            'reminder_time' => 'nullable|date_format:H:i',
            'reminder_channels' => 'nullable|array',
            'privacy' => 'nullable|string|max:20',
            'is_active' => 'nullable|boolean',
        ]);

        $practice->update($validated);
        return response()->json($practice);
    }

    public function destroy(Request $request, Practice $practice)
    {
        if ($request->user()->id !== $practice->user_id) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $practice->delete();
        return response()->json(['message' => 'Practice deleted']);
    }

public function log(Request $request, Practice $practice)
 {
    // Проверяем, что практика принадлежит пользователю
    if ($request->user()->id !== $practice->user_id) {
        return response()->json(['error' => 'Это не твоя практика'], 403);
    }

    $validated = $request->validate([
        'value' => 'nullable|integer',
        'note' => 'nullable|string',
        'photo_url' => 'nullable|url',
    ]);

    $log = $practice->logs()->create([
        'user_id' => $request->user()->id,
        'completed_at' => now(),
        ...$validated
    ]);

 // Проверяем, не завершена ли аскеза
    if ($practice->goal_days && !$practice->completed_at) {
        $logsCount = $practice->logs()->count();
        if ($logsCount >= $practice->goal_days) {
            $practice->completed_at = now();
            $practice->save();
        }
    }


    return response()->json($log, 201);
  }



public function activeUsers(Request $request)
{
    // Получаем ID текущего пользователя, чтобы исключить его из выдачи (опционально)
    $currentUserId = $request->user()->id;

    // Используем фасад DB для более сложного запроса
    $activeUsers = DB::table('users')
        // Присоединяем таблицу practice_logs, чтобы найти только тех, у кого есть отметки
        ->join('practice_logs', 'users.id', '=', 'practice_logs.user_id')
        // Присоединяем таблицу practices, чтобы получить название практики
        ->join('practices', 'practice_logs.practice_id', '=', 'practices.id')
        // Выбираем нужные поля: инфо о пользователе и название практики
        ->select(
            'users.id',
            'users.name',
            'users.avatar_url',
            'practices.name as practice_name',
            'practice_logs.completed_at'
        )
        // Условие: отметка сделана сегодня
        ->whereDate('practice_logs.completed_at', now()->toDateString())
        // Не показываем текущего пользователя (чтобы не было его самого в этом блоке)
        ->where('users.id', '!=', $currentUserId)
        // Группируем, чтобы пользователь не дублировался, если у него несколько практик за сегодня
        ->groupBy('users.id', 'users.name', 'practices.name', 'practice_logs.completed_at')
        // Ограничиваем количество результатов, например, 5
        ->limit(5)
        ->get();

    // Если никого не нашли, можно вернуть пустой массив или заглушку
    if ($activeUsers->isEmpty()) {
        // Можно вернуть пустой массив или массив с "заглушкой", но уже с бэкенда
        return response()->json(['message' => 'Сегодня пока никто не практиковал, кроме вас!', 'data' => []]);
    }

    return response()->json($activeUsers);
  }


public function deleteLog(Request $request, Practice $practice, $logId)
{
    // Проверяем, что практика принадлежит пользователю
    if ($request->user()->id !== $practice->user_id) {
        return response()->json(['error' => 'Это не твоя практика'], 403);
    }
    
    $log = $practice->logs()->find($logId);
    if (!$log) {
        return response()->json(['error' => 'Лог не найден'], 404);
    }
    
    $log->delete();



  // Если удалили лог, сбрасываем completed_at
    if ($practice->goal_days) {
        $logsCount = $practice->logs()->count();
        if ($logsCount < $practice->goal_days) {
            $practice->completed_at = null;
            $practice->save();
        }
    }



    
    return response()->json(['message' => 'Отметка удалена']);
  }






}
