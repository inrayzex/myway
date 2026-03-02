<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use NotificationChannels\Fcm\FcmChannel;
use NotificationChannels\Fcm\FcmMessage;
use NotificationChannels\Fcm\Resources\Notification as FcmNotification;

class NewMessageNotification extends Notification
{
    use Queueable;

    protected $message;
    protected $senderName;

    public function __construct($message, $senderName)
    {
        $this->message = $message;
        $this->senderName = $senderName;
    }

    public function via($notifiable)
    {
        return [FcmChannel::class];
    }

    public function toFcm($notifiable): FcmMessage
    {
        return (new FcmMessage(
            notification: new FcmNotification(
                title: 'Новое сообщение от ' . $this->senderName,
                body: $this->message,
                image: null
            )
        ))->data([
            'type' => 'chat',
            'sender' => $this->senderName,
            'click_action' => 'https://myvay.ru/app/club.html'
        ]);
    }
}
