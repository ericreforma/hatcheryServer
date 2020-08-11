<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SocialMediaCategory extends Model
{
    protected $table = 'social_media_category';
    public $timestamps = false;
    
    public function social_media(){
        return $this->belongsTo('App\SocialMedia','id','social_media_id');
    }

    public function client(){
        return $this->belongsTo('App\Client','id','client_id');
    }
}
