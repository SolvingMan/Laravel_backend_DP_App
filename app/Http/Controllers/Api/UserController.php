<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Backend\Questions;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\DB;
use Session;
use Excel;
use File;

class UserController extends Controller {
    /**
     * Sign up
     */
    public function signup(Request $request) {
        $row = User::where('email', Input::get('email'))->first();
        $row1 = User::where('username', Input::get('username')) ->first(); 
        if (empty($row) && empty($row1)) {
            $userClass = new User();
            $userClass->password = Hash::make($request->input('password'));
            $userClass->first_name = $request->input('username');
            $userClass->last_name = $request->input('username');
            $userClass->username = $request->input('username'); 
            $userClass->email = $request->input('email');
            $userClass->user_level = 2;

            if ($userClass ->save()) {
                $data = ['result' => 'success', 'data' => $userClass];
            } else {
                $data = ['result' => 'error'];
            }
        } else {
            $data = ['result' => 'exist_email'];
        }
        return response()->json($data);
    }

    /**
     * Login
     */
    public function login() {
        if (Auth::attempt(['email' => Input::get('email'), 'password' => Input::get('password')])) {
            $questions =DB::table('questions')->get();
            $data = [
                'result' => 'successful',
                'data' => Auth::user(),
            ];
        } else {
            $data = [
                'result' => 'failed'
            ];
        }
        
        return response()->json($data);
    }

    public function update_theme_setting(Request $request) {
        $email = $request->input('email');
        $swipe = $request->input('swipe');
        $theme_action = $request->input('theme_action');
        $theme_color = $request->input('theme_color');

        $user = User::where('email','LIKE','%'.$email.'%')->first();
        if (!empty($user)) {
            $user ->theme_action = $theme_action;
            $user ->theme_color = $theme_color;
            $user ->swipe = $swipe;
            $user ->save();
            $data = [
                'result' => 'success',
                'user' => $user
            ];
        } 
        else {
            $data = [
                'result' => "failed"
            ];
        }     

        return response()->json($data);
    }

    public function update_notification_setting(Request $request) {
        $email = $request->input('email');
        $notification_action = $request->input('notification_action');
        $notification_type = $request->input('notification_type');
        (int)$batch_size = $request->input('batch_size');
        (int)$frequency = $request->input('frequency');
        $start_time = $request->input('start_time');
        $end_time = $request->input('end_time');

        $user = User::where('email','LIKE','%'.$email.'%')->first();
        if (!empty($user)) {
            $user ->notification_action = $notification_action;
            $user ->notification_type = $notification_type;
            $user ->batch_size = $batch_size;
            $user ->frequency = $frequency;
            $user ->start_time = $start_time;
            $user ->end_time = $end_time;

            $user ->save();
            $data = [
                'result' => 'success',
                'updated_user' => $user
            ];
        } 
        else {
            $data = [
                'result' => "failed"
            ];
        }  
        return response()->json($data);
    }

    public function update_demographics(Request $request) {
        $email = $request->input('email');
        $country_birth = $request->input('country_birth');
        $country_residence = $request->input('country_residence');
        $gender = $request->input('gender');
        $age = $request->input('age');

        $user = User::where('email','LIKE','%'.$email.'%')->first();
        if (!empty($user)) {
            $user ->country_birth = $country_birth;
            $user ->country_residence = $country_residence;
            $user ->gender = $gender;
            $user ->age = $age;

            $user ->save();
            $data = [
                'result' => 'success',
                'updated_user' => $user
            ];
        } 
        else {
            $data = [
                'result' => "failed"
            ];
        }
        return response()->json($data);
    }

    public function get_user_info(Request $request) {
        $email = $request->input('email');

        $user = User::where('email','LIKE','%'.$email.'%')->first();
        if (!empty($user)) {
            $data = [
                'result' => 'success',
                'user' => $user
            ];
        }
        else {
            $data = [
                'result' => 'failed'
            ];
        }
        return response()->json($data);
    }
}
