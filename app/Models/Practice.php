<?php



namespace App\Models;



use Illuminate\Database\Eloquent\Concerns\HasUuids;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Model;



class Practice extends Model

{

    use HasFactory, HasUuids;



    protected $keyType = 'string';

    public $incrementing = false;



    protected $fillable = [

        'user_id',

        'name',

        'type',

        'goal_value',

        'goal_unit',

        'goal_days',

        'period_type',

        'days_of_week',

        'reminder_time',

        'reminder_channels',

        'privacy',

        'is_active',

        'is_binary',

    ];



    protected $casts = [

        'days_of_week' => 'array',

        'reminder_channels' => 'array',

        'is_active' => 'boolean',

    ];



    public function user()

    {

        return $this->belongsTo(User::class);

    }



    public function logs()

    {

        return $this->hasMany(PracticeLog::class);

    }




public function reminders()
{
    return $this->hasMany(Reminder::class);
}





}
