<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SocialMedia extends Model
{
    protected $table = 'social_media';

    public function client(){
      return $this->belongsTo('App\Client','client_id','id');
    }

    public function users(){
      return $this->hasMany('App\UserSocialMediaCampaign','social_media_id','id');
    }
    
    public function posts(){
      return $this->hasMany('App\Post','social_media_id','id');
    }

    public function media(){
      return $this->hasMany('App\Media','holder_id','id')->where('holder','2');
    }

    public function tags(){
      return $this->hasMany('App\SocialMediaTag','social_media_id','id');
    }

    public function budgets(){
      return $this->hasMany('App\SocialMediaBudget','social_media_id','id');
    }

    public function categories(){
      return $this->hasMany('App\SocialMediaCategory','social_media_id','id');
    }

    public function sma(){
      return $this->hasMany('App\SocialMediaSM','social_media_id','id');
    }
}
