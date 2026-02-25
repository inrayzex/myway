<?php



namespace Database\Factories;



use App\Models\User;

use Illuminate\Database\Eloquent\Factories\Factory;



class PracticeFactory extends Factory

{

    public function definition(): array

    {

        $types = ['медитация', 'йога', 'спорт', 'правильное питание', 'сон', 'чтение'];

        $units = ['минуты', 'часы', 'км', 'разы', 'страницы'];

        

        return [

            'id' => fake()->uuid(),

            'user_id' => User::factory(),

            'name' => fake()->randomElement([
    'утренняя медитация',
    'йога перед сном',
    'пробежка в парке',
    'осознанное питание',
    'дневник благодарности',
    'вечерняя прогулка',
    'тренировка в зале',
    'медитация осознанности',
    'цигун утром',
    'отказ от сахара',
    'ранний подъем',
    'чтение перед сном',
]),

            'type' => fake()->randomElement($types),

            'goal_value' => fake()->numberBetween(5, 60),

            'goal_unit' => fake()->randomElement($units),

            'goal_days' => fake()->optional(0.3)->numberBetween(7, 100),

            'period_type' => fake()->randomElement(['daily', 'weekly']),

            'days_of_week' => fake()->optional(0.5)->randomElements([1,2,3,4,5,6,7], 3),

            'reminder_time' => fake()->optional(0.7)->time('H:i'),

            'reminder_channels' =>fake()->optional(0.5)->randomElements(['telegram', 'email', 'push'], 2),

            'privacy' => fake()->randomElement(['private', 'friends', 'public']),

            'is_active' => fake()->boolean(80),

        ];

    }

}
