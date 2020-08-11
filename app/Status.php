<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    protected $table = 'status';

    // STATUS CODES

        // TYPE 
            // 1 - CAMPAIGN
            // 2 - USER
            // 3 - JOB APPLICATION
            
        // SOURCE  - Source of Type
            // TYPE 1 - CAMPAIGN
                //  1 - SOCIAL MEDIA
                //  2-  EVENT
                //  4 - POST 
                
            // TYPE 2 - USER
                //  1 - CLIENT
                //  2 - USER

            // TYPE 3 - JOB APPLICATION
                //  1 - USER

            
}           

            