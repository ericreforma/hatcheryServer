<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserSocialMediaCampaign extends Model
{
    protected $table = 'user_socialmedia_campaign';

    public function profile(){
        return $this->belongsTo('App\User','user_id','id');
    }

    public function parentCampaign(){
        return $this->belongsTo('App\SocialMedia','social_media_id','id');
    }

    public function posts(){
        return $this->hasMany('App\Post','user_sm_campaign_id','id')->where('status', '<>','CANCELLED');
    }
    
    public function client(){
        return $this->belongsTo('App\Client','client_id','id');
    }
}
