<?php

use Faker\Generator as Faker;

$factory->define(App\CampaignTag::class, function (Faker $faker) {
    return [
        'type' => rand(0, 1),
        'caption' => $faker->lastName,
    ];
});
