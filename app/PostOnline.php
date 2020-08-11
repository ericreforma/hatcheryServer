<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PostOnline extends Model
{
    protected $table = 'post_online';

    public function user(){
        return $this->belongsTo('App\User','user_id','id');
    }

    public function post(){
        return $this->belongsTo('App\Post','post_id','id');
    }

    public function campaign(){
        return $this->belongsTo('App\SocialMedia','social_media_id','id');
    }

    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }

    
}
