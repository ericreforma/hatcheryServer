<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\ChatSession;
use App\Chat;

use App\User;
use App\Client;
use App\Category;
use App\UserCategory;
use App\UserCampaign;
use App\UserSMA;
use App\SocialMedia;
use App\Media;
use App\Vehicle;
use App\UserRating;
use App\Post;
use App\Event;
use App\EventApplicants;
use App\ReportProblem;
use DB;
use Carbon\Carbon;
use stdClass;
use Storage;
use Mail;
use Hash;
use Kreait\Firebase;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;

class UserController extends Controller
{
  /**
     * Create a new controller instance.
     *
     * @return void
     */

  public function __construct()  {
      $this->middleware('auth:api');
  }

  public function login(Request $request){
    $credential = json_decode($request->cred, false);
    $count = User::where('uid',$credential->uid)->count();
    $isExist = false;

    if($count > 0){
      $isExist = true;
      $user = User::where('uid',$credential->uid)->first();
    } else {
      $user = new User;
      $user->uid =  $credential->uid;
      $user->name =  $credential->displayName;
      $user->email =  $credential->email;
      $user->save();

      // SAVE MEDIA
      $media = new Media;
      $media->owner = 0;
      $media->owner_id = $user->id;
      $media->holder = 0;
      $media->holder_id = $user->id;
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

    return response()->json(['isExist' => $isExist, 'profile' => $this->profile($user->uid)]);
  }

  public function signup(Request $request){
    $thisUser = json_decode($request->userData, false);

    $user = new User;
    $user->uid = $thisUser->uid;
    $user->name = $thisUser->name;
    $user->email = $thisUser->email;
    $user->save();
  }

  private function user($uid){
    $thisUser = User::where('uid', $uid)->first();
    $user = User::find($thisUser->id);
    return $user;
  }

  private function saveMedia($owner_id, $file, $directory) {
    $media = new Media;
    $media->owner = 0;
    $media->owner_id = $owner_id;
    $media->holder = 0;
    $media->holder_id = $owner_id;
    $media->type = 0;
    $media->file_type = $file->getMimeType();
    $media->extension = $file->extension();
    $media->save();
    
    $media->filename = $media->owner . '_' . $media->owner_id . '_' . $media->id . '.' . $media->extension;
    $media->url = 'media/user/' . $media->filename;
    $file = $file->storeAs('/media/user',$media->filename, $directory);
    $media->save();

    return $media->id;
  }
  
  private function profile($uid){
    $categories = [];

    $ratings = new stdClass();
    $ratings_count = 0;
    $ratings_sum = 0;

    $user = User::where('uid', $uid)->first();
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

  public function logout (Request $request) {
    $user = $request->user();

    $token = $user->token();
    $token->revoke();

    $response = 'You have been succesfully logged out!';
    return response($response, 200);
  }
  
  public function details(Request $request){
    // return response()->json($request->user());

    return response()->json($this->profile($request-uid));
  }

  public function profileUpdate(Request $request){

    $user = User::where('uid', $request->uid)->first();

    $user->username = $request->username === null ? '' : $request->username;
    $user->description = $request->description === null || $request->description === 'null' ? null : $request->description;
    $user->gender = $request->gender === null ? '' : $request->gender;
    $user->birthdate = $request->birthdate;
    $user->contact_number = $request->contact_number === null ? '' : $request->contact_number;
    $user->location = $request->location === null ? '' : $request->location;
    $user->phone_verified = $request->phone_verified;
    $user->phone_prefix = $request->phone_prefix;

    $user->country_id = $request->country_id;

    $user->save();

    if($request->profilePhotoChanged == 1){
      $user->media_id = $this->saveMedia($user->id, $request->file('profilePhoto'), 'public');
      $user->save();
    }
    
    return response()->json($this->profile($user->uid));
  }

  public function ratings(Request $request){

    $user = User::where('uid', $request->uid)->first()->ratings();

    return response()->json($user);
  }

  public function category_browse(Request $request){
    $categories = Category::select('id as category_id','description')->get();

    return response()->json($categories);
  }

  public function category_save(Request $request){
    $myCategories =  json_decode($request->myCategories, false);
    $user = User::where('uid', $request->uid)->first();

    $user->category()->delete();

    foreach($myCategories as $cat) {
      $category = new UserCategory;
      $category->user_id = $user->id;
      $category->category_id = $cat->category_id;
      $category->description = $cat->description;
      $category->save();      
    }

    return response()->json($this->profile($user->uid));
  }

  public function chatSession_create(Request $request){
    $user = User::where('uid', $request->uid)->first();

    $count = ChatSession::where('campaign_type',$request->campaign_type)
                  ->where('campaign_id',$request->campaign_id)
                  ->where('user_id',$user->id)
                  ->where('client_id',$request->client_id)
                  ->count();

    if($count > 0){
      $chatSession =  ChatSession::where('campaign_type',$request->campaign_type)
                    ->where('campaign_id',$request->campaign_id)
                    ->where('user_id',$user->id)
                    ->where('client_id',$request->client_id)
                    ->first();
    } else {
      $chatSession = new ChatSession;
      $chatSession->user_id = $user->id;
      $chatSession->client_id = $request->client_id;
      $chatSession->campaign_type = $request->campaign_type;
      $chatSession->campaign_id = $request->campaign_id;
      $chatSession->save();
    } 

    return $chatSession;
  }
  public function chatSession_list(Request $request){
    $user = User::where('uid', $request->uid)->first();
    $list = ChatSession::where('user_id', $user->id)->get();

    foreach($list as $li) {
      $li->client->media;
      
      if($li->campaign_type == 1) {
        $campaign = SocialMedia::find($li->campaign_id);
      } else{
        $campaign = Event::find($li->campaign_id)->with('media');
      }
      $li->campaign = $campaign;
      $li->campaign->media;
    }

    return $list;
  }

  public function chat_send(Request $request){
    $notification = new NotificationController();
		$client = Client::find($request->client_id);
    $user = User::where('uid', $request->uid)->first();
    
    $chat = new Chat;
    $chat->session_id = $request->session_id;
    $chat->user_id = $user->id;
    $chat->client_id = $request->client_id;
    $chat->campaign_type = $request->campaign_type;
		$chat->campaign_id = $request->campaign_id;
    $chat->type = $request->type;
    $chat->sender = $request->sender;
    $chat->message = $request->message;
    $chat->attachment = null;
    $chat->save();
    
    $session = ChatSession::find($request->session_id);
    $session->new_message = $request->message;
    $session->save();

    broadcast(new \App\Events\ChatEvent($request->session_id));
    broadcast(new \App\Events\NotificationEvent($user->id));

    $title = $client->business_name . ' sent you a message';
    $body = substr($request->message, 0, 25);
    $error = 'no error';

    try{
      $notification->notify_device($title, $body, null, $user->fcm_token);
		} catch (Throwable $e) {
			$error = 'unable to notify device';
    }
    
    return response()->json([
			'id' => $chat->id,
			'sending_id' => $request->sending_id,
			'error' => $error
		]);
  }

  public function chat_read(Request $request){
    $session = ChatSession::find($request->session_id);
    $session->has_read = 1;
    $session->save();
  }

  public function chat_delete(Request $request) {
    $chat = Chat::find($request->chat_id);
    $chat->isDelete = 1;
    $chat->save();
    broadcast(new \App\Events\ChatEvent($chat->session_id, 'forDelete', $chat->id));
    return response()->json(['status' => 'success']);
  }

  public function chat_history(Request $request){
    $chathistory = Chat::where('session_id', $request->session_id)->get();

    return $chathistory;
  }

  public function reportProblem(Request $request) {
    $user = User::where('uid', $request->uid)->first();

    $problem = new ReportProblem;
    $problem->email = $user->email;
    $problem->message = $request->message;
    $problem->title = $request->title;
    $problem->subject = $request->subject;
    $problem->save();

    Mail::send('mail.reportProblem', ['problem' => $problem] , function ($message) use ($user){
        $message->from('no-reply@thehatchery.app', 'Hatchery');
        $message->replyto('no-reply@thehatchery.app', 'Hatchery');
        $message->subject("[Hatchery] Problem Reported");
        $message->to($user->email);
        $message->bcc('ericreforma@gmail.com');
        $message->bcc('jatlynkianatan@gmail.com');
    });
    
    return response()->json(['status' => 'success']);
  }

  public function testMail() {
    $data = [];
    $verification_code = 1234;

    Mail::send('mail.verificationCode',  ['verification_code' => $verification_code], function ($message) use ($verification_code) {
      $message->from('ericreforma@gmail.com', 'Hatchery');
      $message->replyto('ericreforma@gmail.com', 'Hatchery');
      $message->subject("Verification Code");
      $message->to('ericreforma@gmail.com');
    });

    return response()->json(['success' => 'test']);
  }

  public function verifyCode(Request $request) {
    $user = User::where('uid', $request->uid)->first();

    if(Hash::check($request->code, $user->email_verification_code)){
      $user->email_verified = 1;
      $user->email_verified_at = Carbon::now();
      $user->save();

      return response(['status' => 'verified']);
    }

    return response(['status' => 'error']);
  }
  public function verifyCodeResend(Request $request) {
    $user = User::where('uid', $request->uid)->first();
    $verification_code = $this->generateRandom(5);
    
    $email = $user->email;
    $user->email_verification_code = Hash::make($verification_code);;
    $user->save();
    
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

  public function fcm_token_update(Request $request){
    $user = User::where('uid', $request->uid)->first();

    $user->fcm_token = $request->token;
    $user->save();
  }

  public function firebaseUserTest(Request $request){
    // returns nothing
    return response()->json(['user' => $request->user()]);
  }

  public function linkAccount(Request $request) {
    $user = User::where('uid', $request->uid)->first();

    $userSMA = new UserSMA;
    $userSMA->user_id = $user->id;
    $userSMA->app_id = $request->app_id;
    $userSMA->app_user_id = $request->app_user_id;
    $userSMA->type = $request->type;
    $userSMA->type_name = $request->type_name;
    $userSMA->access_token = $request->access_token;
    $userSMA->credential = $request->credential;
    $userSMA->username = $request->username;
    $userSMA->user_link = $request->user_link;
    $userSMA->profile_picture = $request->profile_picture;
    $userSMA->page_id = $request->page_id;
    $userSMA->page_name = $request->page_name;
    $userSMA->page_username = $request->page_username;
    $userSMA->page_access_token = $request->page_access_token;
    $userSMA->page_link = $request->page_link;
    $userSMA->page_fan_count = $request->page_fan_count;
    $userSMA->page_profile_picture = $request->page_profile_picture;
    $userSMA->save();

    return response()->json($this->profile($user->uid));
  }
}

