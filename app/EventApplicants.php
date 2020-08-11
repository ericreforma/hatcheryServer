<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EventApplicants extends Model
{
    protected $table = 'event_applicants';

    public function event(){
        return $this->belongsTo('App\Event','event_id','id');
    }

    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }

    public function job(){
        return $this->belongsTo('App\EventJobs','eventjob_id','id');
    }

    public function profile(){
        return $this->belongsTo('App\User','user_id','id');
    }
}
