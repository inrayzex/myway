<?php



namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;

use App\Models\ClubPost;

use App\Models\Club;

use App\Models\User;

use Illuminate\Http\Request;

use App\Models\ClubMessage;

class ClubController extends Controller

{

    public function index()

    {

        $clubs = Club::with('creator', 'members')->get();

        return response()->json($clubs);

    }




public function store(Request $request)
{
    $user = $request->user();

    $validated = $request->validate([
        'name' => 'required|string|max:100',
        'description' => 'nullable|string',
        'type' => 'nullable|string|max:20',
        'cover' => 'nullable|image|max:5120', // 5MB
    ]);

    $club = Club::create([
        'name' => $validated['name'],
        'description' => $validated['description'] ?? null,
        'type' => $validated['type'] ?? 'open',
        'creator_id' => $user->id,
    ]);

    if ($request->hasFile('cover')) {
        $path = $request->file('cover')->store('club_covers', 'public');
        $club->cover_url = $path;
        $club->save();
    }

    $club->members()->attach($user->id, ['role' => 'creator']);

    return response()->json($club->load('creator', 'members'), 201);
}




public function show(Club $club)
{
    $club->load([
        'creator',
        'members',
        'posts.user',
    ]);

    // Добавляем количество лайков и комментариев к каждому посту
    foreach ($club->posts as $post) {
        $post->likes_count = $post->likes()->count();
        $post->comments_count = $post->comments()->count();
        $post->liked_by_user = auth()->check() 
            ? $post->likes()->where('user_id', auth()->id())->exists() 
            : false;
    }

    return response()->json($club);
}





    public function join(Request $request, Club $club)

    {

         $user = $request->user();

        

        if ($club->members()->where('user_id', $user->id)->exists()) {

            return response()->json(['message' => 'Already a member'], 400);

        }



        $club->members()->attach($user->id, ['role' => 'member']);

        return response()->json(['message' => 'Joined successfully']);

    }

         public function leave(Request $request, Club $club)
            {
                $user = $request->user();
    
                 // Проверяем, является ли пользователь создателем
                 if ($user->id === $club->creator_id) {
                 return response()->json(['message' => 'Создатель не может покинуть клуб'], 400);
                           }
    
                 // Проверяем, состоит ли пользователь в клубе
                if (!$club->members()->where('user_id', $user->id)->exists()) {
                    return response()->json(['message' => 'Вы не в клубе'], 400);
                            }
    
                $club->members()->detach($user->id);
                return response()->json(['message' => 'Вы покинули клуб']);
   }





// Чат
public function messages(Club $club)
{
    return $club->messages()->with('user')->latest()->take(50)->get()->reverse()->values();
}

public function sendMessage(Request $request, Club $club)
{
    $request->validate([
        'content' => 'required|string|max:1000',
    ]);

    $message = $club->messages()->create([
        'user_id' => $request->user()->id,
        'content' => $request->content,
    ]);

    return response()->json($message->load('user'), 201);
}



public function storePost(Request $request, Club $club)
{
    // Проверяем, что пользователь состоит в клубе
    if (!$club->members()->where('user_id', $request->user()->id)->exists()) {
        return response()->json(['error' => 'Вы не в клубе'], 403);
    }

    $request->validate([
        'content' => 'required|string',
        'photo' => 'nullable|image|max:5120', // 5MB
    ]);

    $post = $club->posts()->create([
        'user_id' => $request->user()->id,
        'content' => $request->content,
    ]);

    if ($request->hasFile('photo')) {
        $path = $request->file('photo')->store('club_posts', 'public');
        $post->photo_url = $path;
        $post->save();
    }

    return response()->json($post->load('user'), 201);
}


public function deletePost(Request $request, $postId)
{
    $post = ClubPost::findOrFail($postId);
    
    if ($request->user()->id !== $post->user_id) {
        return response()->json(['error' => 'Unauthorized'], 403);
    }

    $post->delete();
    return response()->json(['message' => 'Post deleted']);
 }




public function destroy(Club $club)
{
    if (request()->user()->id !== $club->creator_id) {
        return response()->json(['error' => 'Только создатель может удалить клуб'], 403);
    }
    
    $club->delete();
    return response()->json(['message' => 'Клуб удален']);
}






}
