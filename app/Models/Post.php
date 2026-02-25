<?php



namespace App\Models;



use Illuminate\Database\Eloquent\Concerns\HasUuids;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Model;



class Post extends Model

{

    use HasFactory, HasUuids;



    protected $keyType = 'string';

    public $incrementing = false;



    protected $fillable = [

        'user_id',

        'content',

        'photo_url',

        'privacy',

        'club_id',

    ];



    public function user()

    {

        return $this->belongsTo(User::class);

    }



    public function club()

    {

        return $this->belongsTo(Club::class);

    }



    public function likes()

    {

        return $this->hasMany(PostLike::class);

    }



    public function comments()

    {

        return $this->hasMany(Comment::class);

    }

}
