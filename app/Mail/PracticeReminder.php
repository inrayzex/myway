<?php

namespace App\Mail;

use App\Models\Practice;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class PracticeReminder extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(
        public Practice $practice
    ) {}

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Напоминание: ' . $this->practice->name,
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.practice-reminder',
            with: [
                'practice' => $this->practice,
            ]
        );
    }
}
