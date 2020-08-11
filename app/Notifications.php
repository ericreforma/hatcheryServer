<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Notifications extends Model
{
    protected $table = 'notification';

    // user_type
        // 0 = user
        // 1 = client
    
    // type
        // 0 = message
        // 1 = post status
        // 2 = payment status
}



