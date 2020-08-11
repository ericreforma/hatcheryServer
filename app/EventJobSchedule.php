<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EventJobSchedule extends Model
{
    protected $table = 'event_job_schedule';

    public $timestamps = false;

    public function event(){
        return $this->belongsTo('App\Event','event_id','id');
    }

    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }

    public function job(){
        return $this->belongsTo('App\EventJobs','job_id','id');
    }

    public function eventjob(){
        return $this->belongsTo('App\EventJobSchedule','eventjob_id','id');
    }

}
