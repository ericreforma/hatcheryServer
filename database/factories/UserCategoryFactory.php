<?php

use Faker\Generator as Faker;

$factory->define(App\UserCategory::class, function (Faker $faker) {
    return [
        'category_id' => rand(0,37)
    ];
});
