<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserSMA extends Model
{
    protected $table = 'user_sma';

    public function user(){
        return $this->belongsTo('App\User','id','user_id');
    }
}
