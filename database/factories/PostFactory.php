<?php



namespace Database\Factories;



use App\Models\User;

use Illuminate\Database\Eloquent\Factories\Factory;



class PostFactory extends Factory

{

    public function definition(): array

    {

        return [

            'id' => fake()->uuid(),

            'user_id' => User::factory(),

            'content' => fake()->paragraphs(3, true),

            'photo_url' => fake()->optional(0.4)->imageUrl(),

            'privacy' => fake()->randomElement(['private', 'friends', 'public']),

            'club_id' => null, ];

    }

}
