<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $table = 'event';

    public function jobs(){
        return $this->hasMany('App\EventJobs','event_id','id');
    }

    public function client(){
        return $this->belongsTo('App\Client','client_id', 'id');
    }

    public function media(){
        return $this->hasMany('App\Media','holder_id','id')->where('holder','3');
    }

    public function schedule(){
        return $this->hasMany('App\EventSchedule', 'event_id', 'id');
    }
    
    public function applicants(){
        return $this->hasMany('App\EventApplicants', 'event_id', 'id');
    }
    
}
