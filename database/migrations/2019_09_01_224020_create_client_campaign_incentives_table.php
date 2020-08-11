<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClientCampaignIncentivesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('campaign_incentives', function (Blueprint $table) {
          $table->bigIncrements('id');
          $table->integer('campaign_id');
          $table->integer('from');
          $table->integer('to');
          $table->integer('type');
          $table->integer('cost');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('campaign_incentives');
    }
}
