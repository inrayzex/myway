<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class SendPracticeReminders extends Command
{
    protected $signature = 'reminders:send';
    protected $description = 'Отправка напоминаний о практиках';

    public function handle()
    {
        $now = now();
        $currentTime = $now->format('H:i');


        $practices = DB::table('practices')
            ->where('is_active', true)
            ->whereRaw('TO_CHAR(reminder_time, \'HH24:MI\') = ?', [$currentTime])
            ->join('users', 'practices.user_id', '=', 'users.id')
            ->select('practices.*', 'users.email', 'users.fcm_token')
            ->get();

        $count = 0;

        $factory = (new Factory)->withServiceAccount('storage/app/firebase/myvay-73784-firebase-adminsdk-fbsvc-044750b7b6.json');
        $messaging = $factory->createMessaging();

        foreach ($practices as $practice) {
            if ($practice->fcm_token) {
                $channels = json_decode($practice->reminder_channels, true) ?? [];
                if (in_array('push', $channels)) {
                    try {
                        $message = [
                            'token' => $practice->fcm_token,
                            'notification' => [
                                'title' => ' Напоминание о практике',
                                'body' => "Пора: {$practice->name}",
                            ],
                            'data' => [
                                'click_action' => 'https://myvay.ru/app/profile.html'
                            ]
                        ];


                        $messaging->send($message);
                        $this->info(" Уведомление отправлено пользователю {$practice->email}");
                        $count++;
                    } catch (\Exception $e) {
                        $this->error(" Ошибка для {$practice->email}: {$e->getMessage()}");
                    }
                }
            }
        }

        $this->info("Всего отправлено: {$count}");
        return 0;
    }
}
