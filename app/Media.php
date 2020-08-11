<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Media extends Model
{
    protected $table = 'media';
    // OWNER
        // who owns the media file
        // 0 - user
        // 1 - client
        
    // HOLDER
        // where the media file is used for
        // 0 - user
        // 1 - client
        // 2 - social media campaign
        // 3 - event
        // 4 - post
}
