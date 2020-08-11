<?php

use Faker\Generator as Faker;

$factory->define(App\UserSocialMedia::class, function (Faker $faker) {
    return [
        'type' => rand(0, 4),
        'username' => $faker->username,
        'link' => $faker->url,
        'followers' => rand(100000, 51000000)
      ];
});
