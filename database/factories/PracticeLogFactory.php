<?php



namespace Database\Factories;



use App\Models\Practice;

use App\Models\User;

use Illuminate\Database\Eloquent\Factories\Factory;



class PracticeLogFactory extends Factory

{

    public function definition(): array

    {

        return [

            'id' => fake()->uuid(),

            'practice_id' => Practice::factory(),

            'user_id' => User::factory(),

            'completed_at' => fake()->dateTimeBetween('-3 months', 'now'),

            'value' => fake()->numberBetween(5, 60),

            'note' => fake()->optional(0.3)->sentence(),

            'photo_url' => fake()->optional(0.1)->imageUrl(),

        ];

    }

}
