<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('start_question',  'Api\QuestionController@start_question');

Route::get('next_question',  'Api\QuestionController@next_question');

Route::get('positive_cs',  'Api\QuestionController@positive_cs');

Route::post('add_permission',  'Api\QuestionController@add_permission');

Route::get('get_handshakes',  'Api\QuestionController@get_handshakes');

Route::get('delete_comapre_traits',  'Api\QuestionController@delete_comapre_traits');

Route::get('generate_code',  'Api\QuestionController@generate_code');

Route::get('get_permission_code',  'Api\QuestionController@get_permission_code');

Route::post('update_notification_setting',  'Api\UserController@update_notification_setting');

Route::post('update_demographics',  'Api\UserController@update_demographics');

Route::post('update_theme_setting',  'Api\UserController@update_theme_setting');

Route::get('get_user_info',  'Api\UserController@get_user_info');






// Get video file in video edit page
Route::get('video/uploaded/{id}', 'Api\VideoController@uploadedVideo')->where('id', '[0-9]+');

// Sign up
Route::post('user/signup', 'Api\UserController@signup');

// Login
Route::post('user/login', 'Api\UserController@login');

// Get video categories
Route::post('video/get_categories', 'Api\VideoCategoryController@getCategories');

// Get videos by category and user
Route::get('video/get_videos', 'Api\VideoController@getVideosByCategoryAndUser');

// Get user's favorite videos
Route::get('video/get_favorite_videos', 'Api\VideoController@getFavoriteVideos');

// Get video by id
Route::get('video/get_video', 'Api\VideoController@getVideo')->where('id', '[0-9]+');

// Add favorite to video
Route::post('video/add_favorite', 'Api\VideoController@addFavorite');

// Remove favorite
Route::post('video/remove_favorite', 'Api\VideoController@removeFavorite');
