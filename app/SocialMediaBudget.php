<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SocialMediaBudget extends Model
{
    protected $table = 'social_media_budget';
    public $timestamps = false;

    public function social_media(){
        return $this->belongsTo('App\SocialMedia');
    }

}
