<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    protected $table = 'post';

    public function user(){
        return $this->belongsTo('App\User','user_id','id');
    }

    public function campaign(){
        return $this->belongsTo('App\SocialMedia','social_media_id','id');
    }

    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }

    public function userCampaign(){
        return $this->hasMany('App\UserSocialMediaCampaign','user_sm_campaign_id','id');
    }

    public function sma(){
        return $this->hasMany('App\PostSMA','post_id','id');
    }
    
    public function media(){
        return $this->hasMany('App\Media','holder_id','id')->where('holder','4');
    }

    public function mediaCollection(){
        return $this->hasMany('App\Media','owner_id','id')->where('owner', 3);
    }

    public function online(){
        return $this->hasOne('App\PostOnline','post_id','id');
    }
}
