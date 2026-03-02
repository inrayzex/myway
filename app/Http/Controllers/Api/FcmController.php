<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class FcmController extends Controller
{
    public function saveToken(Request $request)
    {
        $request->validate([
            'fcm_token' => 'required|string',
            'email' => 'required|email'
        ]);

        $user = User::where('email', $request->email)->first();
        
        if ($user) {
            $user->fcm_token = $request->fcm_token;
            $user->save();
            return response()->json(['message' => 'Token saved successfully']);
        }

        return response()->json(['error' => 'User not found'], 404);
    }
}
