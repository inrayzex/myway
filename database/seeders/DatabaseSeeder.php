<?php



namespace Database\Seeders;



use App\Models\User;

use App\Models\Practice;

use App\Models\PracticeLog;

use App\Models\Post;

use Illuminate\Database\Seeder;



class DatabaseSeeder extends Seeder

{

    public function run(): void

    {
      $users = User::factory(10)->create();
            foreach ($users as $user) {

            $practices = Practice::factory()

                ->count(rand(2, 5))

                ->for($user)

                ->create();

 foreach ($practices as $practice) {

                PracticeLog::factory()

                    ->count(rand(10, 30))

                    ->for($practice)

                    ->for($user)

                    ->create();

            }

  Post::factory()

                ->count(rand(3, 8))

                ->for($user)

                ->create();

        }

 $this->createFollows($users);

    }



    private function createFollows($users)

    {

        foreach ($users as $user) {

 $others = $users->where('id', '!=', $user->id)->random(rand(3, 7));

            

            foreach ($others as $target) {

                try {

                    $user->followings()->attach($target->id, [

                        'created_at' => now(),

                        'updated_at' => now(),

                    ]);

                } catch (\Exception $e) {

 }

            }

        }

    }

}

