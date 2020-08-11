<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EventSchedule extends Model
{
    protected $table = 'event_schedule';
    public $timestamps = false;
    
    public function event(){
        return $this->belongsTo('App/Event','event_id','id');
    }
}
