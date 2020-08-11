<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCategoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('category', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('description');
        });

        DB::table('category')->insert([
            ['description' => 'Techie'],
            ['description' => 'Foodie'],
            ['description' => 'Adventurous'],
            ['description' => 'Funny'],
            ['description' => 'Hacktivist'],
            ['description' => 'Sociable'],
            ['description' => 'Party Goer'],
            ['description' => 'Sporty'],
            ['description' => 'Biker'],
            ['description' => 'Car Enthusiast'],
            ['description' => 'Educator'],
            ['description' => 'Music Lover'],
            ['description' => 'Gamer'],
            ['description' => 'Fashionista'],
            ['description' => 'Hiker'],
            ['description' => 'Prankster'],
            ['description' => 'Mr./Ms. Science'],
            ['description' => 'Religion'],
            ['description' => 'Artist'],
            ['description' => 'Actor/Actress'],
            ['description' => 'Good Samaritan'],
            ['description' => 'Animal Lover'],
            ['description' => 'Wild'],
            ['description' => 'KPOP'],
            ['description' => 'Political'],
            ['description' => 'Rebellious'],
            ['description' => 'Bookworm'],
            ['description' => 'Movie'],
            ['description' => 'War Freak'],
            ['description' => 'Curious'],
            ['description' => 'Detective'],
            ['description' => 'Beauty and Wellness'],
            ['description' => 'Conspiracy'],
            ['description' => 'Marine Life'],
            ['description' => 'Trendy'],
            ['description' => 'Photography'],
            ['description' => 'Fit'],
            ['description' => 'Reviewer']
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('category');
    }
}
