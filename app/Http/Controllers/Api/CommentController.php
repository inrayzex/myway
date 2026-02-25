<?php



namespace App\Http\Controllers\Api;



use App\Http\Controllers\Controller;

use App\Models\Comment;

use App\Models\Post;

use App\Models\User;

use Illuminate\Http\Request;



class CommentController extends Controller

{

   public function index(Post $post)
    {
      return $post->comments()->with('user')->latest()->get();
    }

      public function store(Request $request, Post $post)
        {
          $validated = $request->validate([
           'content' => 'required|string',
              ]);

    $comment = $post->comments()->create([
        'user_id' => $request->user()->id,
        'content' => $validated['content']
               ]);

            return response()->json($comment->load('user'), 201);
         }


    public function destroy(Comment $comment)

    {

        $comment->delete();

        return response()->json(['message' => 'Comment deleted']);

    }

}
