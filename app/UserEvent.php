<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserEvent extends Model
{
    protected $table = 'user_event';

    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }
    public function parentEvent(){
        return $this->belongsTo('App\Event','event_id','id');
    }

    public function skill(){
        return $this->belongsTo('App\Skill','skill_id','id');
    }

    public function job(){
        return $this->belongsTo('App\EventJobCosting','job_id','id');
    }
  
}
