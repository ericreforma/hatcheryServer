<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SocialMediaSM extends Model
{
    protected $table = 'social_media_sma';

    public $timestamps = false;

    public function SocialMedia(){
        return $this->belongsTo('App\SocialMedia');
    }
}
