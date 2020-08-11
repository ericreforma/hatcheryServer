<?php

use Faker\Generator as Faker;

$factory->define(App\CampaignIncentives::class, function (Faker $faker) {
    return [
      'from' => rand(100, 300),
      'to' => rand(500, 800),
      'type' => rand(0, 3),
      'cost' => rand(1000, 8000)
    ];
});
