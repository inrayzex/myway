<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;

use App\Models\Post;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Storage;


class PostController extends Controller

{



public function index(Request $request)
{
    // Если передан user_id  показываем посты конкретного пользователя
    if ($request->has('user_id')) {
        $posts = Post::where('user_id', $request->user_id)
            ->with('user')
            ->withCount('likes', 'comments')
            ->latest()
            ->get();
            
        // Добавляем флаг liked_by_user для текущего пользователя
        if ($request->user()) {
            foreach ($posts as $post) {
                $post->liked_by_user = $post->likes()
                    ->where('user_id', $request->user()->id)
                    ->exists();
            }
        }
        
        return response()->json($posts);
    }
    
    // Иначе показываем ленту для текущего пользователя
    $posts = Post::with(['user', 'comments'])
        ->withCount('likes', 'comments')
        ->withExists(['user as is_friend' => function ($query) use ($request) {
            $query->whereIn('users.id', $request->user()->followings()->pluck('users.id'));
        }])
        ->latest()
        ->paginate(20);

    $posts->getCollection()->transform(function ($post) use ($request) {
        $post->liked_by_user = $post->likes()
            ->where('user_id', $request->user()->id)
            ->exists();
        return $post;
    });

    return response()->json($posts);
}




public function store(Request $request)
{
    $validated = $request->validate([
        'content' => 'required|string',
        'privacy' => 'nullable|in:private,friends,public',
        'photo' => 'nullable|image|max:5120' // 5MB
    ]);

    $post = new Post();
    $post->user_id = $request->user()->id;
    $post->content = $validated['content'];
    $post->privacy = $validated['privacy'] ?? 'private';

    if ($request->hasFile('photo')) {
        $path = $request->file('photo')->store('posts', 'public');
        $post->photo_url = $path;
    }

    $post->save();

    return response()->json($post, 201);
}




    public function show(Post $post)

    {

        return response()->json($post->load(['user', 'likes', 'comments']));

    }
  public function update(Request $request, Post $post)

    {
 if ($request->user()->id !== $post->user_id) {

            return response()->json(['error' => 'Unauthorized'], 403);

        }



        $validated = $request->validate([

            'content' => 'sometimes|string',

            'photo_url' => 'nullable|url',

            'privacy' => 'nullable|in:private,friends,public',

        ]);



        $post->update($validated);



        return response()->json($post);

    }



    public function destroy(Request $request, Post $post)

    {

        if ($request->user()->id !== $post->user_id) {

            return response()->json(['error' => 'Unauthorized'], 403);

        }



        $post->delete();



        return response()->json(['message' => 'Post deleted']);

    }


public function pin(Request $request, Post $post)
{
    if ($request->user()->id !== $post->user_id) {
        return response()->json(['error' => 'Это не твой пост'], 403);
    }

    $post->is_pinned = true;
    $post->save();

    return response()->json(['message' => 'Пост закреплён']);
}

public function unpin(Request $request, Post $post)
{
    if ($request->user()->id !== $post->user_id) {
        return response()->json(['error' => 'Это не твой пост'], 403);
    }

    $post->is_pinned = false;
    $post->save();

    return response()->json(['message' => 'Закрепление отменено']);
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






}
