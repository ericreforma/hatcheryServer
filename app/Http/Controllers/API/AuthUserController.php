<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use stdClass;
use Storage;
use App\Media;
use App\User;
use App\UserSMA;
use Hash;
use Mail;
use Carbon\Carbon;

class AuthUserController extends Controller
{
    public function __construct(){
      auth()->setDefaultDriver('api_auth');
    }

    private function profile($id){
      $categories = [];
  
      $ratings = new stdClass();
      $ratings_count = 0;
      $ratings_sum = 0;
  
  
      $user = User::find($id);
      $media = Media::find($user->media_id);
      $user->media = $media;
      
      // Ratings
      // foreach($user->ratings as $r){
      //   $ratings_count += 1;
      //   $ratings_sum += $r->rate;
      // }
  
      // $ratings->total = $ratings_sum;
      // $ratings->count = $ratings_count;
      // $ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);
  
      $ratings->total = 100;
      $ratings->count = 100;
      $ratings->average = 5;
  
      $user->rating = $ratings;
      $user->category;
      $user->socialMedia;
      $user->notifications;
      $user->unreadNotifications;
      $user->country;
  
      return ($user);
    }
    public function login(Request $request){
      $credentials = [
          'email' => $request->email,
          'password' => $request->password
      ];

      if (auth()->attempt($credentials)) {
          $token = auth()->user()->createToken('tapads')->accessToken;
          return response()->json(['token' => $token], 200);
      } else {
          return response()->json(['error' => 'UnAuthorised'], 401);
      }
    }

    public function firebaseLogin(Request $request){
      $credential = json_decode($request->cred, false);
      $count = User::where('uid',$credential->uid)->count();
      $isExist = false;
  
      if($count > 0){
        $isExist = true;
        $user = User::where('uid',$credential->uid)->first();
        $user->fcm_token = $request->fcmtoken;
        $user->save();
        
      } else {
        $verification_code = $this->generateRandom(5);

        $user = new User;
        $user->uid =  $credential->uid;
        $user->name =  $credential->displayName;
        $user->email =  $credential->email;
        $user->fcm_token = $request->fcmtoken;
        $user->password = property_exists($credential, 'password') ? Hash::make($credential->password) : null;
        $user->country_id = 2;
        $user->email_verification_code = Hash::make($verification_code);;
        $user->save();
  
        if(property_exists($credential, 'photoURL')){
          // SAVE MEDIA
          $media = new Media;
          $media->owner = 2;
          $media->owner_id = $user->id;
          $media->type = 0;
          $media->file_type = 'image/jpeg';
          $media->extension = 'jpeg';
          $media->save();
          
          $media->filename = $media->owner . '_' . $media->owner_id . '_' . $media->id . '.' . $media->extension;
          $media->url = 'media/user/' . $media->filename;
    
          Storage::disk('public')->put($media->url, file_get_contents($credential->photoURL));
          $media->save();

          $user->media_id =  $media->id;
          $user->save();
        }

        if (property_exists($credential, 'sma')) {
          foreach($credential->sma as $sm){
            $socialMedia = new UserSMA;
            $socialMedia->user_id = $user->id;
            $socialMedia->type = $sm->sma;
            $socialMedia->username = $sm->value;
            $socialMedia->followers = 0;
            $socialMedia->save();
          }
        }

        $this->sendmail($user->email, $verification_code);
        
      }
  
      return response()->json(['isExist' => $isExist, 'profile' => $this->profile($user->id)]);
    }
    public function signup (Request $request){
      $data = json_decode($request->userData, true);
      $messages = [
        'required' => ':attribute',
      ];

      $validator = Validator::make($data,[
        'name' => 'required|string|max:255',
        'email' => 'required|email',
        'password' => 'required',
      ], $messages);

      if($validator->fails()){
        return response()->json($validator->errors()->all(), 400);
      }

      $data['password'] = Hash::make($data['password']);
      $verification_code = $this->generateRandom(5);

      $data['email_verification_code'] = Hash::make($verification_code);
      
      $user = User::create($data);
      $sma = json_decode($request->sma, false);

      foreach($sma as $sm){
        $socialMedia = new UserSMA;
        $socialMedia->user_id = $user->id;
        $socialMedia->type = $sm->sma;
        $socialMedia->username = $sm->value;
        $socialMedia->followers = 0;
        $socialMedia->save();
      }
      
      $token = $user->createToken('tapads')->accessToken;
      $this->sendmail($data['email'], $verification_code);
      
      return response()->json(['token' => $token], 200);
    }

    public static function sendmail($email, $verification_code){
      Mail::send('mail.verificationCode',['verification_code'=> $verification_code], function ($message) use ($email){
          $message->from('no-reply@thehatchery.app', 'Hatchery');
          $message->replyto('no-reply@thehatchery.app', 'Hatchery');
          $message->subject("[Hatchery] Verification Code");
          $message->to($email);
      });
    }

    public function generateRandom($length){
      $characters = '0123456789';
      $string = '';
      $max = strlen($characters) - 1;
      for ($i = 0; $i < $length; $i++) {
           $string .= $characters[mt_rand(0, $max)];
      }
      return $string;
    }
}
