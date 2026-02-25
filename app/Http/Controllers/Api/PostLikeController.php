<?php



namespace App\Http\Controllers\Api;



use App\Http\Controllers\Controller;

use App\Models\Post;

use App\Models\User;

use Illuminate\Http\Request;



class PostLikeController extends Controller

{




public function like(Request $request, Post $post)
{
    if ($post->likes()->where('user_id', $request->user()->id)->exists()) {
        return response()->json(['message' => 'Already liked'], 400);
    }

    $post->likes()->create([
        'user_id' => $request->user()->id
    ]);

    return response()->json([
        'message' => 'Post liked',
        'likes_count' => $post->likes()->count()
    ]);
}





public function unlike(Request $request, Post $post)
{
    $deleted = $post->likes()
        ->where('user_id', $request->user()->id)
        ->delete();

    if (!$deleted) {
        return response()->json(['message' => 'Like not found'], 404);
    }

    return response()->json([
        'message' => 'Post unliked',
        'likes_count' => $post->likes()->count()
    ]);
 }








}
