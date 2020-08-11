<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Socialite;
use App\User;

class FacebookAuthController extends Controller
{
    public function redirectToProvider(){
        return Socialite::driver('facebook')->redirect();
    }

    public function handleProviderCallback(){
        $user = Socialite::driver('facebook')->user();
    }
}
