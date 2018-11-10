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
            $table->integer('confirmed');
            $table->integer('confirmed_str');
            $table->string('country_birth');
            $table->string('country_residence');
            $table->string('gender');
            $table->integer('age');
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
