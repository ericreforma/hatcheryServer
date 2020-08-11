<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use App\Client;
use App\Media;
use Hash;

class AuthClientController extends Controller
{
	public function __construct(){
		auth()->setDefaultDriver('web');
	}

	public function index(){
		return redirect('/login');
		//return response()->json(['account_needed' => 'login'], 401);
	}

  public function login(Request $request){
		$credentials = [
			'email' => $request->email,
			'password' => $request->password
		];

		if (auth()->attempt($credentials)) {
			$token = auth()->user()->createToken('influencer')->accessToken;
			return response()->json(['token' => $token], 200);
		} else {
			return response()->json(['error' => 'UnAuthorised'], 401);
		}
  }


  public function signup (Request $request){
		$validator = Validator::make($request->all(),[
			'name' => 'required|string|max:255',
			'email' => 'required|email|unique:client,email',
			'password' => 'required',
		]);

		if($validator->fails()){
			return response()->json(['errors'=>$validator->errors()],422);
		}

		$request['password']=Hash::make($request['password']);

		$user = Client::create([
			'name' => $request->name,
			'business_name' => $request->business_name,
			'email' => $request->email,
			'password' => $request->password,
			'contact_number' => $request->contact_number,
		]);

		$token = $user->createToken('influencer')->accessToken;
		return response()->json(['token' => $token], 200);
  }

  public function test( Request $request) {
	  return response()->json(['test' => 'testingcompolete']);
  }
}
