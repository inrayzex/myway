<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClubPostLike extends Model
{
    use HasFactory, HasUuids;

    protected $keyType = 'string';
    public $incrementing = false;

    protected $fillable = [
        'user_id',
        'club_post_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function clubPost()
    {
        return $this->belongsTo(ClubPost::class);
    }
}
