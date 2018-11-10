<?php

namespace App\Http\Controllers\backend;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Backend\Questions;


class QuestionsController extends Controller
{
    //
    public function questions() {
        return view('backend.questions.questions');
    }
}
