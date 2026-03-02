<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Recommendation;
use Illuminate\Http\Request;

class RecommendationController extends Controller
{
    public function index()
    {
        $recommendations = Recommendation::where('is_active', true)
            ->orderBy('sort_order')
            ->get();
        
        return response()->json($recommendations);
    }
}
