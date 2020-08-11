<?php

namespace App;

use Laravel\Passport\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;
    protected $guard = 'api';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'description', 
        'birthdate', 'gender', 'location', 'username', 'contact_number',
        'email_verification_code'

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
      return $this->belongsToMany('App\Chat');
    }

    public function ratings(){
      return $this->hasMany('App\UserRating');
    }

    public function posts() {
      return $this->hasMany('App\Post','user_id','id');
    }

    public function socialMediaCampaigns(){
      return $this->hasMany('App\UserSocialMediaCampaign','user_id','id');
    }
    
    public function socialMedia() {
      return $this->hasMany('App\UserSMA','user_id','id');
    }

    public function category(){
      return $this->hasMany('App\UserCategory','user_id','id');
    }

    public function events(){
      return $this->hasMany('App\UserEvent','user_id','id');
    }
    
    public function media(){
      return $this->hasOne('App\Media','id','media_id');
    }

    public function notifications(){
      return $this->hasMany('App\Notifications','to_id','id')->where('user_type', 0)->orderBy('created_at', 'desc');
    }

    public function country(){
      return $this->hasOne('App\Country', 'id', 'country_id');
    }

    public function unreadNotifications(){
      return $this->hasMany('App\Notifications','to_id','id')->where('user_type', 0)->where('isOpened', 0)->orderBy('created_at', 'desc');
    }
  }
