<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class UsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('username', 30)->unique();
            $table->string('email')->unique();
            $table->string('password');
            $table->integer('user_level');
            // $table->integer('confirmed');
            // $table->integer('confirmed_str');
            $table->string('country_birth')->default('United States');
            $table->string('country_residence')->default('United States');
            $table->string('gender')->default('male');
            $table->integer('age')->default(1);
            $table->string('theme_action')->default('static');
            $table->string('theme_color')->default('dark');
            $table->string('swipe')->default('disable');
            $table->string('notification_action')->default('disable');
            $table->string('notification_type')->default('casual');
            $table->integer('batch_size')->default(30);
            $table->integer('frequency')->default(1);
            $table->string('start_time')->default('00:00');
            $table->string('end_time')->default('00:00');
            $table->integer('complete_question_id')->default(1);
            $table->string('permission_code')->default("123456");
            
            $table->string('avatar')->nullable();
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::table('users', function (Blueprint $table) {
            //
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('users');

        Schema::table('users', function (Blueprint $table) {
            //
        });
    }
}
