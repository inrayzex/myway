<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Article;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    public function index()
    {
        $articles = Article::latest()->get();
        return response()->json($articles);
    }

    public function show(Article $article)
    {

     \Log::info('=== МЕТОД SHOW ВЫЗВАН ===', [
        'article_id' => $article->id,
        'article_title' => $article->title
    ]);
        
        return response()->json($article);
    }
}
