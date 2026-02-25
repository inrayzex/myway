<?php

namespace App\Console\Commands;

use App\Models\Practice;
use App\Models\Reminder;
use App\Mail\PracticeReminder;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class SendPracticeReminders extends Command
{
    protected $signature = 'reminders:send';
    protected $description = 'Send scheduled practice reminders';

    public function handle()
    {
        $now = now();
        
        // Находим все практики с напоминаниями на это время
        $practices = Practice::where('reminder_time', '<=', $now->format('H:i:s'))
            ->where('is_active', true)
            ->whereDoesntHave('reminders', function ($query) use ($now) {
                $query->whereDate('scheduled_at', $now->toDateString());
            })
            ->get();

        foreach ($practices as $practice) {
            if (!$practice->user) continue;

            // Отправляем письмо
            Mail::to($practice->user->email)->send(new PracticeReminder($practice));

            // Сохраняем запись о напоминании
            Reminder::create([
                'user_id' => $practice->user_id,
                'practice_id' => $practice->id,
                'channel' => 'email',
                'scheduled_at' => $now,
                'sent_at' => $now,
                'is_sent' => true,
            ]);

            $this->info("Reminder sent for practice: {$practice->name}");
        }

        return Command::SUCCESS;
    }
}
