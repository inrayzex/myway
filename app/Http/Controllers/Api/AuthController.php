<?php



namespace App\Http\Controllers\Api;



use App\Http\Controllers\Controller;

use App\Models\User;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Hash;

use Illuminate\Validation\ValidationException;

use Illuminate\Support\Str;


class AuthController extends Controller

{


public function register(Request $request)
{
    try {
        $request->validate([
            'name' => 'required|string|max:255',
            'username' => 'required|string|max:50|unique:users',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);
    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json([
            'message' => 'Ошибка валидации',
            'errors' => $e->errors()
        ], 422);
    }

    $user = User::create([
        'id' => \Illuminate\Support\Str::uuid(),
        'name' => $request->name,
        'username' => $request->username,
        'email' => $request->email,
        'password' => \Illuminate\Support\Facades\Hash::make($request->password),
        'status' => 'ищущий',
    ]);

    $token = $user->createToken('auth_token')->plainTextToken;

    return response()->json([
        'user' => $user,
        'token' => $token,
    ], 201);
}





 public function login(Request $request)

{

    $request->validate([

        'email' => 'required|email',

        'password' => 'required',

    ]);



    $user = User::where('email', $request->email)->first();



    if (! $user || ! Hash::check($request->password, $user->password)) {

        return response()->json([

            'message' => 'The provided credentials are incorrect.'

        ], 401);

    }



    $token = $user->createToken('auth_token')->plainTextToken;



    return response()->json([

        'user' => $user,

        'token' => $token,

    ]);

}


    public function logout(Request $request)

    {

        $request->user()->currentAccessToken()->delete();



        return response()->json(['message' => 'Logged out successfully']);

    }



    public function user(Request $request)

    {

        return response()->json($request->user());

    }




public function test()
{
    return response()->json(['test' => 'ok']);
}





}
