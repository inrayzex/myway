<?php



namespace App\Models;



use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Model;



class ClubMember extends Model

{

    use HasFactory;



    protected $table = 'club_members';



    protected $fillable = [

        'club_id',

        'user_id',

        'role',

    ];



    public $incrementing = false;

    protected $primaryKey = ['club_id', 'user_id'];



    public function club()

    {

        return $this->belongsTo(Club::class);

    }



    public function user()

    {

        return $this->belongsTo(User::class);

    }

}
