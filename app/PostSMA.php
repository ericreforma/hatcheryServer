<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PostSMA extends Model
{
    protected $table = 'post_sma';
    public $timestamps = false;

    public function post(){
        return $this->belongsTo('App\Post','post_id','id');
    }

}
