<?php



namespace App\Models;



use Illuminate\Database\Eloquent\Concerns\HasUuids;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Model;



class ClubPost extends Model

{

    use HasFactory, HasUuids;



    protected $keyType = 'string';

    public $incrementing = false;



    protected $table = 'club_posts';



    protected $fillable = [

        'club_id',

        'user_id',

        'content',

        'photo_url',

    ];



    public function club()

    {

        return $this->belongsTo(Club::class);

    }



    public function user()

    {

        return $this->belongsTo(User::class);

    }



public function likes()
{
    return $this->hasMany(ClubPostLike::class, 'club_post_id');
}



public function comments()
{

 return $this->hasMany(ClubPostComment::class, 'club_post_id');

}







}
