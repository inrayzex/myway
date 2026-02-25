<?php



namespace Database\Factories;



use Illuminate\Database\Eloquent\Factories\Factory;

use Illuminate\Support\Facades\Hash;

use Illuminate\Support\Str;



class UserFactory extends Factory

{

    protected static ?string $password;



    public function definition(): array

    {

        return [

            'id' => Str::uuid(),

            'name' => fake()->name(),

            'email' => fake()->unique()->safeEmail(),

            'password' => static::$password ??= Hash::make('password'),

            'username' => fake()->unique()->userName(),

            'status' => fake()->randomElement(['seeker', 'practitioner', 'guide']),

            'quote' => fake()->optional()->sentence(),

            'email_verified_at' => now(),

            'remember_token' => Str::random(10),

        ];

    }

}
