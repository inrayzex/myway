<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;


class UserController extends Controller
{
    public function follow(Request $request, User $user)
    {
        if ($request->user()->id === $user->id) {
            return response()->json(['error' => 'Нельзя подписаться на себя'], 400);
        }

        $request->user()->followings()->syncWithoutDetaching([$user->id]);

        return response()->json(['message' => 'Подписка оформлена']);
    }

    public function unfollow(Request $request, User $user)
    {
        $request->user()->followings()->detach($user->id);

        return response()->json(['message' => 'Подписка отменена']);
    }

   //подписка

   public function suggestions(Request $request)
    {
    $users = User::where('id', '!=', $request->user()->id)
        ->limit(5)
        ->get();

    $users->each(function ($user) use ($request) {
        $user->is_following = $request->user()->followings()
            ->where('following_id', $user->id)
            ->exists();
    });

    return response()->json($users);
   }



//editing profile
public function updateQuote(Request $request)
{
    $request->validate([
        'quote' => 'nullable|string|max:255'
    ]);
    
    $user = $request->user();
    $user->quote = $request->quote;
    $user->save();
    
    return response()->json(['message' => 'Цитата обновлена']);
}



public function updateStatus(Request $request)
{
    $request->validate([
        'status' => 'nullable|string|max:50'
    ]);
    
    $user = $request->user();
    $user->status = $request->status ?: null;
    $user->save();
    
    return response()->json(['message' => 'Статус обновлен']);
}


public function updatePrivacy(Request $request)
{
    $request->validate([
        'type' => 'required|in:trackers,posts',
        'value' => 'required|in:только я,друзья,все'
    ]);
    
    $user = $request->user();
    $field = $request->type === 'trackers' ? 'trackers_privacy' : 'posts_privacy';
    $user->$field = $request->value;
    $user->save();
    
    return response()->json(['message' => 'Приватность обновлена']);
}

public function deleteAvatar(Request $request)
{
    $user = $request->user();
    
    if ($user->avatar_url) {
        Storage::disk('public')->delete($user->avatar_url);
        $user->avatar_url = null;
        $user->save();
    }
    
    return response()->json(['message' => 'Аватар удален']);
 }

public function uploadAvatar(Request $request)
{
    $request->validate([
        'avatar' => 'required|image|max:2048'
    ]);

    $user = $request->user();
    
    $path = $request->file('avatar')->store('avatars', 'public');

    if ($user->avatar_url) {
        Storage::disk('public')->delete($user->avatar_url);
    }

    $user->avatar_url = $path;
    $user->save();
    
    // Возвращаем обновлённые данные пользователя
    return response()->json([
        'message' => 'Аватар загружен',
        'user' => $user
    ]);
 }





public function followings(Request $request)
{
    return $request->user()->followings()->get([
        'users.id',
        'users.name',
        'users.username',
        'users.status',
        'users.avatar_url'
    ]);
}


public function followers(Request $request)
{
    return $request->user()->followers()->get([
        'users.id',
        'users.name',
        'users.username',
        'users.status',
        'users.avatar_url'
    ]);
}




  public function updateName(Request $request)
  {
    $request->validate([
        'name' => 'required|string|max:255'
    ]);

    $user = $request->user();
    $user->name = $request->name;
    $user->save();

    return response()->json(['message' => 'Имя обновлено']);
  }




}
