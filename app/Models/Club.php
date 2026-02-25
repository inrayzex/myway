<?php



namespace App\Models;



use Illuminate\Database\Eloquent\Concerns\HasUuids;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Model;



class Club extends Model

{

    use HasFactory, HasUuids;



    protected $keyType = 'string';

    public $incrementing = false;



    protected $fillable = [

        'name',

        'description',

        'cover_url',

        'creator_id',

        'type',

    ];



    public function creator()

    {

        return $this->belongsTo(User::class, 'creator_id');

    }



    public function members()

    {

        return $this->belongsToMany(User::class, 'club_members')

                    ->withPivot('role')

                    ->withTimestamps();

    }



    public function posts()

    {

     return $this->hasMany(ClubPost::class)->latest();

    }


    public function messages()
   {
    return $this->hasMany(ClubMessage::class);
    }

}
