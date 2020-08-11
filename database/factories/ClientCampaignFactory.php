<?php

use Faker\Generator as Faker;

$factory->define(App\Campaign::class, function (Faker $faker) {
    return [
      'name' => $faker->name,
      'description' => $faker->realText,
      'type' => rand(0, 2),
      'media_id' => rand(1,10),
      'gender' => rand(0, 2),
      'followers' => rand(100, 3000),
      'age_from' => rand(18, 22),
      'age_to' => rand(23, 45),
      'deadline' => $faker->dateTime(),
      'social_media' =>rand(0, 4),
    ];
});
