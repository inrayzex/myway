<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PostController;
use App\Http\Controllers\Api\PracticeController;
use App\Http\Controllers\Api\ClubController;
use App\Http\Controllers\Api\PostLikeController;
use App\Http\Controllers\Api\CommentController;
use App\Models\User;



Route::post('/register', [AuthController::class, 'register'])->withoutMiddleware(['auth:sanctum']);

Route::post('/login', [AuthController::class, 'login']);

   Route::middleware('auth:sanctum')->group(function () {


    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::get('/practices/active-users', [App\Http\Controllers\Api\PracticeController::class, 'activeUsers']);

    Route::get('/articles', [App\Http\Controllers\Api\ArticleController::class, 'index']);

    Route::get('/articles/{article}', [App\Http\Controllers\Api\ArticleController::class, 'show']);

    Route::post('/users/{user}/follow', [App\Http\Controllers\Api\UserController::class, 'follow']);
    Route::delete('/users/{user}/unfollow', [App\Http\Controllers\Api\UserController::class, 'unfollow']);
    Route::get('/users/suggestions', [App\Http\Controllers\Api\UserController::class, 'suggestions']);
    Route::delete('/practices/{practice}/log/{log}', [App\Http\Controllers\Api\PracticeController::class, 'deleteLog']);



     Route::post('/clubs/posts/{post}/like', [App\Http\Controllers\Api\ClubPostLikeController::class, 'like']);
     Route::delete('/clubs/posts/{post}/unlike', [App\Http\Controllers\Api\ClubPostLikeController::class, 'unlike']);

     Route::get('/clubs/posts/{post}/comments', [App\Http\Controllers\Api\ClubPostCommentController::class, 'index']);
     Route::post('/clubs/posts/{post}/comments', [App\Http\Controllers\Api\ClubPostCommentController::class, 'store']);
     Route::delete('/clubs/comments/{comment}', [App\Http\Controllers\Api\ClubPostCommentController::class, 'destroy']);


    // routes profile.html
    // Редактирование профиля
    Route::put('/user/quote', [App\Http\Controllers\Api\UserController::class, 'updateQuote']);
    Route::put('/user/status', [App\Http\Controllers\Api\UserController::class, 'updateStatus']);
    Route::put('/user/privacy', [App\Http\Controllers\Api\UserController::class, 'updatePrivacy']);
    Route::post('/user/avatar', [App\Http\Controllers\Api\UserController::class, 'uploadAvatar']);
    Route::delete('/user/avatar', [App\Http\Controllers\Api\UserController::class, 'deleteAvatar']);
    Route::get('/users/followings', [App\Http\Controllers\Api\UserController::class, 'followings']);
    Route::get('/users/followers', [App\Http\Controllers\Api\UserController::class, 'followers']);




    Route::get('/users', function (Request $request) {
    return App\Models\User::where('id', '!=', $request->user()->id)
        ->limit(5)
        ->get(['id', 'name']);
   });



Route::get('/users/all', function (Request $request) {
    $limit = $request->get('limit', 20);
    return App\Models\User::where('id', '!=', $request->user()->id)
        ->limit($limit)
        ->get(['id', 'name', 'username', 'status', 'avatar_url']);
});




Route::get('/users/search', function (Request $request) {
    $query = $request->get('q');
    $limit = $request->get('limit', 50);

    if (!$query || strlen($query) < 2) {
        return response()->json([]);
    }

    return User::where('id', '!=', $request->user()->id)
        ->where(function ($q) use ($query) {
            $q->where('name', 'ilike', "%{$query}%")
              ->orWhere('username', 'ilike', "%{$query}%");
        })
        ->limit($limit)
        ->get(['id', 'name', 'username', 'status', 'avatar_url']);
});


       Route::get('/users/{user}', function (Request $request, $userId) {
        $user = App\Models\User::findOrFail($userId);
        $user->is_following = $request->user()->followings()
        ->where('following_id', $userId)
        ->exists();
    return $user;
   });




    Route::get('/clubs/{club}/messages', [ClubController::class, 'messages']);
    Route::post('/clubs/{club}/messages', [ClubController::class, 'sendMessage']);
    Route::post('/clubs/{club}/posts', [App\Http\Controllers\Api\ClubController::class, 'storePost']);



    Route::post('/logout', [AuthController::class, 'logout']);

    
    

   
    Route::apiResource('practices', PracticeController::class);
    Route::post('/practices/{practice}/log', [PracticeController::class, 'log']);

    
    Route::apiResource('clubs', ClubController::class);
    Route::post('/clubs/{club}/join', [ClubController::class, 'join']);
    Route::delete('/clubs/{club}/leave', [ClubController::class, 'leave']);

    Route::post('/posts/{post}/pin', [App\Http\Controllers\Api\PostController::class, 'pin']);
    Route::post('/posts/{post}/unpin', [App\Http\Controllers\Api\PostController::class, 'unpin']);
    Route::post('/posts/{post}/like', [PostLikeController::class, 'like']);
    Route::delete('/posts/{post}/unlike', [PostLikeController::class, 'unlike']);
    Route::delete('/posts/{post}', [App\Http\Controllers\Api\PostController::class, 'destroy']);
    Route::delete('/clubs/posts/{post}', [App\Http\Controllers\Api\ClubController::class, 'deletePost']);
    Route::get('/posts/{post}/comments', [CommentController::class, 'index']);
    Route::post('/posts/{post}/comments', [CommentController::class, 'store']);

    Route::apiResource('posts', PostController::class);

    Route::delete('/comments/{comment}', [CommentController::class, 'destroy']);

});
