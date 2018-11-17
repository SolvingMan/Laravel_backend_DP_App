<?php

namespace App\Http\Controllers\backend;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Backend\Questions;
use App\Models\Backend\Traits;
use App\Models\Backend\Qtkey;

use Illuminate\Support\Facades\DB;
use Session;
use Excel;
use File;

class QuestionsController extends Controller
{
    //
    public function questions() {
        return view('backend.questions.questions');
    }
    public function importquestions(Request $request) {
      
        $this->validate($request, array(
            'file'      => 'required'
        ));
       
        if($request->hasFile('file')){
            $extension = File::extension($request->file->getClientOriginalName());
            if ($extension == "xlsx" || $extension == "xls" || $extension == "csv") {
     
                $path = $request->file->getRealPath();
                $data = Excel::load($path, function($reader) {
                })->get();
               
                if(!empty($data) && $data->count()){
     
                    foreach ($data as $key => $value) {
                        //  Read data from one Row
                        $question = $value->text;
                        $trait = $value->label_unformatted;
                        $key = $value->key;
                        $exist_trait = false;
                        $exist_question = false;
                        // Validation each data
                        if (!empty($question) || !empty($trait) || !empty($key)) {

                            // Find the same questions and traits in "question"  and "traits" Table
                            $same_questions = Questions::where('questions','LIKE','%'.$question.'%')->get();

                            // Questions
                            if ( count($same_questions) > 0) {
                                $question_id = $same_questions[0]->id;
                                $exist_question = true;           // Get Question Id from "question"  Table 
                            }
                            else {
                                // Insert New Question in "question" Table and get question_id
                                $exist_question = false;
                                $insert_questions = [
                                'questions' => $question,
                                ];
                                $insertData = DB::table('questions')->insert($insert_questions);
                                $same_question = Questions::where('questions','LIKE','%'.$question.'%')->get();
                                $question_id = $same_question[0]->id;
                            }

                            $same_traits = Traits::where('traits','LIKE','%'.$trait.'%')->get();
                            //  Traits
                            if ( count($same_traits) > 0 ) {
                                $trait_id = $same_traits[0]->id;
                                $exist_trait = true;
                            }
                            else {
                                // Insert New Trait in "traits" Table
                                $exist_trait = false;
                                $insert_traits = [
                                    'traits' => $trait,
                                ];
                                $insertData = DB::table('traits')->insert($insert_traits);
                                $same_trait = Traits::where('traits','LIKE','%'.$trait.'%')->get();
                                $trait_id = $same_trait[0]->id;
                            }
                        
                            // if (!($exist_trait && $exist_question) ) {
                                // Insert question_id, traits_id, and key in "qtkey" Table
                                $insert = [
                                    'question_id' => $question_id,
                                    'traits_id' => $trait_id,
                                    'key' => $key
                                ];
                                
                                $insertData = DB::table('qtkey')->insert($insert);
                                if ($insertData) {
                                    continue;
                                }else {                        
                                    Session::flash('error', 'Error inserting the data..');
                                    echo("here is error");
                                    exit;
                                    return back();
                                }
                            // }
                        } 
                    }
                }
                Session::flash('success', 'Your Data has successfully imported', $key + 5);
                return back();
     
            }else {
                Session::flash('error', 'File is a '.$extension.' file.!! Please upload a valid xls/csv file..!!');
                return back();
            }
        }
    }
}
