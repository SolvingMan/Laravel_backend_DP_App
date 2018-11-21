<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use App\Models\User;
use App\Models\Backend\Questions;
use App\Models\Backend\PersonCS;
use App\Models\Backend\Traits;
use App\Models\Backend\Qtkey;
use App\Models\Backend\CompareCS;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\DB;

class QuestionController extends Controller
{
    //
    public function start_question(Request $request) {
        $email = $request->input('email');
        (int)$question_id = $request->input('question_id');
        $question = DB::table('questions')->where('id', $question_id)->first();
        $user = DB::table('users')->where('email', $email)->first();
       
        if ( !empty($question))  {
            $data = [
                'result' => 'success',
                'question' => $question,
                'user' =>  $user
            ];
        }
        else {
            $data = [
                'result' => 'failed'
            ];
        }
     
        return response()->json($data);
    }

    public function next_question(Request $request) {
        $email = $request->input('email');
        (int)$question_id = $request->input('question_id');
        $answer = $request->input('answer');

        $email_id = User::where('email','LIKE','%'.$email.'%')->first()->id;
        
        $question_traits_values = DB::table('qtkey')->where('question_id', $question_id)->get();
      
            foreach ($question_traits_values as $question_traits_value) {
              
                $row = DB::table('personcs')->where('person_id', $email_id)->where('trait_id', $question_traits_value->traits_id)->first();
                
                if (($row)) {
                    $person_cs = PersonCS::find($row->id);
                    if ($answer == 'agree') {
                        $person_cs->cs = $person_cs->cs + $question_traits_value ->key;
                        $person_cs->save();
                    }
                    else if ($answer == 'disagree') {
                        $person_cs->cs =  $person_cs->cs - $question_traits_value->key;
                        $person_cs->save();
                    }
                    else {}
                }
                else {
                    $new_person_cs = new PersonCS();
                    $new_person_cs->person_id = $email_id;
                    $new_person_cs->trait_id = $question_traits_value->traits_id;
                    if  ($answer == 'agree') {
                        $new_person_cs->cs = $question_traits_value->key;
                        $new_person_cs->save();
                    }
                    else if ($answer == 'disagree') {
                        $new_person_cs->cs = 0 - $question_traits_value->key;
                        $new_person_cs->save();
                    }
                    else {}
                }
            } 
            // exit;
        
        $user =User::where('email','LIKE','%'.$email.'%')->first();
        $user ->complete_question_id = $question_id;
        $user ->save();

        $question = DB::table('questions')->where('id', $question_id + 1)->first();
        $person_cs =  DB::table('personcs')->where('person_id', $email_id)->get();
        if ( !empty($question))  {
            $data = [
                'result' => 'success',
                'question' => $question,
                'email' =>  $email,
                'quesiton_traits_values' => $question_traits_values,
                'email_id' => $email_id,
                'person_cs' => $person_cs,
            ];
        }
        else {
            $data = [
                'result' => 'failed'
            ];
        }
        return response()->json($data);
    }

    
    public function positive_cs(Request $request) {
        $email = $request->input('email');
        $email_isset = User::where('email','LIKE','%'.$email.'%')->first();

        if (!empty($email_isset)) {
            $user_negative_cs = DB::table('personcs')->where('person_id', $email_isset->id)->orderBy('cs')->get();
            $user_positive_cs = DB::table('personcs')->where('person_id', $email_isset->id)->orderBy('cs', 'DESC')->get();
            if (!empty($user_negative_cs) && !empty($user_positive_cs)) {
                foreach ( $user_negative_cs as $cs) {
                    $trait_name = DB::table('traits')->where('id', $cs->trait_id)->first()->traits;
                    $traits_count = DB::table('qtkey')->where('traits_id', $cs->trait_id)->get();
                    $percent = number_format(abs($cs->cs)/count($traits_count) *100, 1);

                    $data_negative[] = [
                        "id" => $cs->id,
                        "person_id" => $cs ->person_id,
                        "trait_name" => $trait_name,
                        "cs" => $cs ->cs,
                        "percent" =>  $percent
                    ];
                };
                foreach ( $user_positive_cs as $cs) {
                    $trait_name = DB::table('traits')->where('id', $cs->trait_id)->first()->traits;
                    $traits_count = DB::table('qtkey')->where('traits_id', $cs->trait_id)->get();
                    $percent = number_format(abs($cs->cs)/count($traits_count) *100, 1);
                    $data_positive[] = [
                        "id" => $cs->id,
                        "person_id" => $cs ->person_id,
                        "trait_name" => $trait_name,
                        "cs" => $cs ->cs,
                        "percent" =>  $percent
                    ];
                }
            
                $data = [
                    'result' => 'success',
                    'email' => $email,
                    'person_cs_negative' => $data_negative,
                    'person_cs_positive' => $data_positive
                ];
            }
            else {
                $data = [
                    'result' => 'failed'
                ];
            }
        }
        else {
            $data = [
                'result' => 'failed'
            ];
        }
      
        return response()->json($data);
    }

    public function add_permission(Request $request) {
        $email = $request->input('email');
        $compare_email = $request->input('compare_email');
        $compare_code = $request -> input('compare_code');
        $compare_traits = $request->input('compare_traits');
         
        $compare_email_isset = User::where('email','LIKE','%'.$compare_email.'%')->first();
        $email_isset = User::where('email','LIKE','%'.$email.'%')->first();

        if ( !empty($compare_email_isset) && !empty($email_isset) ) 
        {
            $compare_permission_isset =  DB::table('comparecs')->where('person_id', $email_isset->id)->where('compare_person_id', $compare_email_isset->id)->first();
            if ( !empty($compare_permission_isset) ) {
                if ($compare_code === $compare_email_isset->permission_code ) {
                    $delete = DB::table('comparecs')->where('person_id', $email_isset->id);
                    $delete->delete();
                    $new_compare = new CompareCS();
                    $new_compare->person_id = $email_isset->id;
                    $new_compare->compare_person_id =  $compare_email_isset->id;
                    $new_compare->compare_traits =serialize($compare_traits);
                    $new_compare->save();
                    $data = [
                        'result' => "successful"
                    ];
                }
                else {
                    $data = [
                        'result' => "Invaild code"
                    ];
                }
            }
            else {
                $new_compare = new CompareCS();
                $new_compare->person_id = $email_isset->id;
                $new_compare->compare_person_id =  $compare_email_isset->id;
                $new_compare->compare_traits = serialize($compare_traits);
                $new_compare->save();
                $data = [
                    'result' => "successfully"
                ];
    
            }          
        }
        else {
            $data = [
                'result' => "failed"
            ];

        }
        return response()->json($data);
    }

    public function get_handshakes(Request $request) {
        $email = $request->input('email');
        $email_isset = User::where('email','LIKE','%'.$email.'%')->first();

        if (!empty($email_isset)) {
            $handshakes = DB::table('comparecs')->where('person_id', $email_isset->id)->get();
            if (!empty($handshakes) && count($handshakes)) {
                foreach ($handshakes as $handshake) {
                    $handshake_email = User::where('id','LIKE','%'.$handshake->compare_person_id.'%')->first()->email;
                    $handshake_compare_cs = unserialize($handshake->compare_traits);
                    $data[] = [$handshake_email => $handshake_compare_cs];
                }
            } else {
                $data = [
                    'result' => "no connection people"
                ];
            }
        }
        else {
            $data = [
                'result' => "failed"
            ];
        }
        return response()->json($data);
    }

    public function delete_comapre_traits(Request $request) {
        $email = $request->input('email');
        $compare_email = $request->input('compare_email');
        $delete_trait = $request->input('delete_trait');

        $email_id = User::where('email','LIKE','%'.$email.'%')->first()->id;
        $compare_email_id = User::where('email','LIKE','%'.$compare_email.'%')->first()->id;

        if (!empty($email_id) && !empty($compare_email_id) ) {
            $compare_traits = DB::table('comparecs')->where('person_id', $email_id)->where('compare_person_id', $compare_email_id)->first()->compare_traits;
            $traits =  unserialize($compare_traits);

            foreach ($traits as $index => $trait ) {
                if ($trait == $delete_trait) {
                    unset($traits[$index]);
                }
            }
            $update_traits_id = DB::table('comparecs')->where('person_id', $email_id)->where('compare_person_id', $compare_email_id)->first()->id;
            $update_traits = CompareCS::where('id', $update_traits_id)->first();
            $update_traits ->compare_traits = serialize($traits);
            $update_traits-> save();
            $data = [
                "result" => "successfully",
                "update_traits" =>$update_traits
            ];
        }
        else {
            $data = [
                "result" => "faield"
            ];
        }
        return response()->json($data);
    }

    // need to test
    public function  generate_code(Request $request ) {
        $email = $request->input('email');

        $email_id = User::where('email','LIKE','%'.$email.'%')->first()->id;

        if (!empty($email_id)) {
            $delete = DB::table('comparecs')->where('compare_person_id', $email_id);
            $delete ->delete();

            $new_permission_code = str_random(6);
            $user =  User::where('id', $email_id)->first();
            $user ->permission_code = $new_permission_code;
            $user ->save();
            $data = [
                'result' => 'successful',
                'code' =>  $new_permission_code,
            ];
                    
        } else {
            $data = [
                'result' => 'failed',
                
            ];
        }
         
        return response()->json($data);
    }

    public function  get_permission_code(Request $request ) {
        $email = $request->input('email');

        $user = User::where('email','LIKE','%'.$email.'%')->first();

        if (!empty($user)) {
            $code = $user->permission_code;

            $data = [
                'result' => 'successful',
                'code' =>  $code,
            ];
                    
        } else {
            $data = [
                'result' => 'failed',
                
            ];
        }
         
        return response()->json($data);
    }


}
