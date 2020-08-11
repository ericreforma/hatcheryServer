<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SocialMediaTag extends Model
{
    protected $table = 'social_media_tags';
    protected $fillable = ['social_media_id'];
    public $timestamps = false;

    public function social_media(){
      return $this->belongsTo('App\SocialMedia');
    }
}
