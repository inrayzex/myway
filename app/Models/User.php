<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasApiTokens;
    use HasUuids;

public function practices()

{

    return $this->hasMany(Practice::class);

}

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
   protected $fillable = [
    'name',
    'email',
    'password',
    'username',
    'status',
    'quote',
    'trackers_privacy',
    'posts_privacy',
    'avatar_url',
];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
public function followings()

{

    return $this->belongsToMany(User::class, 'follows', 'follower_id', 'following_id')

                ->withTimestamps();

}



public function followers()

{

    return $this->belongsToMany(User::class, 'follows', 'following_id', 'follower_id')

                ->withTimestamps();

}
     public function posts()
         {
           return $this->hasMany(Post::class);
          }



public function clubMessages()
{
    return $this->hasMany(ClubMessage::class);
}





}
