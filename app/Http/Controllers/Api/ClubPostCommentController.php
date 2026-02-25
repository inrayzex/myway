<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ClubPost;
use App\Models\ClubPostComment;
use Illuminate\Http\Request;

class ClubPostCommentController extends Controller
{
    public function index(ClubPost $post)
    {
        return $post->comments()->with('user')->latest()->paginate(5);
    }

    public function store(Request $request, ClubPost $post)
    {
        $request->validate([
            'content' => 'required|string',
        ]);

        $comment = $post->comments()->create([
            'user_id' => $request->user()->id,
            'content' => $request->content,
        ]);

        return response()->json($comment->load('user'), 201);
    }

    public function destroy(ClubPostComment $comment)
    {
        $this->authorize('delete', $comment);
        $comment->delete();
        return response()->json(['message' => 'Comment deleted']);
    }
}
