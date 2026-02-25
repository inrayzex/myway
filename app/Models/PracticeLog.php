<?php



namespace App\Models;



use Illuminate\Database\Eloquent\Concerns\HasUuids;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Model;



class PracticeLog extends Model

{

    use HasFactory, HasUuids;



    protected $keyType = 'string';

    public $incrementing = false;



    protected $fillable = [

        'practice_id',

        'user_id',

        'completed_at',

        'value',

        'note',

        'photo_url',

    ];



    protected $casts = [

        'completed_at' => 'datetime',

    ];



    public function practice()

    {

        return $this->belongsTo(Practice::class);

    }



    public function user()

    {

        return $this->belongsTo(User::class);

    }

}
