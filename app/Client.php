<?php

namespace App;

use Laravel\Passport\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Client extends Authenticatable
{
    use HasApiTokens, Notifiable;
    protected $table ='client';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'business_name', 'business_nature','contact_number','media_id'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function chats(){
      return $this->hasMany('App\Chat','client_id','id');
    }

    public function ratings(){
      return $this->hasMany('App\UserRating');
    }

    public function socialmedia(){
      return $this->hasMany('App\SocialMedia','client_id','id');
    }

    public function social_media_budget(){
      return $this->hasMany('App\SocialMediaBudget','client_id','id');
    }

    public function events(){
      return $this->hasMany('App\Event','client_id','id');
    }

    public function media(){
      return $this->hasOne('App\Media','id','media_id');
    }
}
