<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
      $users = factory(App\User::class, 5)->create();
      $clients = factory(App\Client::class, 5)->create();
      $userRating = factory(App\UserRating::class, 40)->create();

      $users->each(function($user){
        $user->socialMedia()->saveMany(factory(App\UserSocialMedia::class, 3)->create(['user_id' => $user->id]));
        $user->category()->saveMany(factory(App\UserCategory::class, 3)->create(['user_id' => $user->id]));
      });


      $clients->each(function($client){
        $client->campaigns()->saveMany(
          factory(App\Campaign::class, 10)->create(['client_id' => $client->id])->each(function($campaign){
            $campaign->tags()->saveMany(factory(App\CampaignTag::class, 2)->create(['campaign_id' => $campaign->id]));
            $campaign->incentives()->saveMany(factory(App\CampaignIncentives::class, 2)->create(['campaign_id' => $campaign->id]));
          })
        );
      });
    }
}
