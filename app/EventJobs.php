<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EventJobs extends Model
{
    protected $table = 'event_jobs';
    public $timestamps = false;
    
    public function event(){
        return $this->belongsTo('App\Event','event_id','id');
    }

    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }

    public function skills(){
        return $this->hasMany('App\EventJobSkills','eventjob_id','id');
    }

    public function applicants(){
        return $this->hasMany('App\EventApplicants','eventjob_id','id');
    }

    public function schedule() {
        return $this->hasMany('App\EventJobSchedule','eventjob_id','id');
    }
}
