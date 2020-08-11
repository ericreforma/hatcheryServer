<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use App\Client;
use App\Chat;
use App\Media;
use App\User;
use App\Category;
use App\Skills;
use App\Jobs;
use App\Event;
use App\EventApplicants;
use App\UserSocialMediaCampaign;
use App\ChatSession;
use App\SocialMedia;
use Carbon\Carbon;
use Hash;
use stdClass; 
use Mail;
use App\Http\Controllers\MediaController;


class ClientController extends Controller
{
	/**
	 * Create a new controller instance.
	 *
	 * @return void
	 */
	// public function __construct()
	// {
	// 	$this->middleware('auth:web_api');
	// }

	/**
	 * Show the application dashboard.
	 *
	 * @return \Illuminate\Contracts\Support\Renderable
	 */
	public function index()
	{
		return view('home');
	}

	public function details(Request $request){
		$client = $request->user();
		$client->media;
		$client->chat;
		
		return response()->json($client);
	}

	private function user($uid){
		$thisUser = Client::where('uid', $uid)->first();
		$user = Client::find($thisUser->id);
		return $user;
	}
	public function users(Request $request) {
		$client =  $request->user();

		$userList = [];
		$useListProfile = [];

		$applicants = EventApplicants::select('user_id')
						->where('client_id', $client->id)->get();
		$socialmedia = UserSocialMediaCampaign::select('user_id')
						->where('client_id', $client->id)->get();

		foreach($applicants as $ap){
			array_push($userList, $ap->user_id);
		}
		foreach($socialmedia as $ap){
			array_push($userList, $ap->user_id);
		}

		$useListProfile = User::whereIn('id',$userList)->with('media')->get();
		
		foreach($useListProfile as $user){
			$chatSession = ChatSession::where('client_uid',$client->uid)
							->where('user_uid',$user->uid)
							->first();

			$user->chatSession = $chatSession;
		}
		return $useListProfile;
	}

	public function login(Request $request) {
		$cred = json_decode($request->user(), false);

		$count = Client::where('uid',$cred->uid)->count();
		$client = null;

		if($count > 0) {
			$client = Client::where('uid',$cred->uid)->first();

		} else {
			$client = new Client;
			$client->uid = $cred->uid;
			$client->name = $cred->displayName;
			$client->business_name = $cred->displayName . "'s Company";
			$client->email = $cred->email;
			$client->save();

			// SAVE MEDIA
			$media = new Media;
			$media->owner = 1;
			$media->owner_id = $client->id;
			$media->type = 0;
			$media->file_type = 'image/jpeg';
			$media->extension = 'jpeg';
			$media->save();

			$media->filename = $media->owner . '_' . $media->owner_id . '_' . $media->id . '.' . $media->extension;
			$media->url = 'media/client/' . $media->filename;

			Storage::disk('public')->put($media->url, file_get_contents($cred->photoURL));
			$media->save();

			$client->media_id =  $media->id;
			$client->save();
		}

		return $client;
	}

	public function logout (Request $request) {
		$token =  $request->user()->token();
		$token->revoke();

		$response = 'You have been succesfully logged out!';
		return response($response, 200);
	}
	
	public function influencer_profile(Request $request){
		$ratings = new stdClass();
		$ratings_count = 0;
		$ratings_sum = 0;
		
		$user = User::find($request->id);
		$user->media;
		// Ratings
		foreach($user->ratings as $r){
			$ratings_count += 1;
			$ratings_sum += $r->rate;
		}
	  
		$ratings->total = $ratings_sum;
		$ratings->count = $ratings_count;
		$ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);
	
		$user->rating = $ratings;

		return $user;
	}
	
	public function categories() {
		return response()->json(Category::all());
	}

	public function skills() {
		return response()->json(Skills::all());
	}

	public function jobs() {
		return response()->json(Jobs::all());
	}

	public function chatSession_get(Request $request){
		$session = ChatSession::
			where('campaign_id', $request->campaign_id)
			->where('campaign_type', $request->campaign_type)
			->where('client_id', $request->user()->id)
			->where('user_id', $request->user_id)
			->first();
		
		return $session;
	}

	public function chatSession_create(Request $request) {
		$count = ChatSession::where('campaign_type',$request->campaign_type)
					  ->where('campaign_id',$request->campaign_id)
					  ->where('user_id',$request->user()->id)
					  ->where('client_id',$request->client_id)
					  ->count();
	
		if($count > 0){
		  $chatSession =  ChatSession::where('campaign_type',$request->campaign_type)
						->where('campaign_id',$request->campaign_id)
						->where('user_id',$request->user()->id)
						->where('client_id',$request->client_id)
						->first();
		} else {
		
			$chatSession = new ChatSession;
			$chatSession->user_id = $request->user()->id;
			$chatSession->client_id = $request->client_id;
			$chatSession->campaign_type = $request->campaign_type;
			$chatSession->campaign_id = $request->campaign_id;
			$chatSession->client_read = 1;
			$chatSession->user_read = 0;
			$chatSession->new_message = 'Say hi to your client';
			$chatSession->new_message_from = 1;
			$chatSession->save();
		} 
	
		return $chatSession;
	}
	
	public function chatSession_list(Request $request){
		$chatSession = ChatSession::
				where('campaign_id', $request->campaign_id)
				->where('campaign_type', $request->campaign_type)
				->get();

		foreach($chatSession as $chat){
			$ratings = new stdClass();
			$ratings_count = 0;
			$ratings_sum = 0;

			$user = $chat->user;
			$user->media;
			
			foreach($user->ratings as $r){
				$ratings_count += 1;
				$ratings_sum += $r->rate;
			}
		  
			$ratings->total = $ratings_sum;
			$ratings->count = $ratings_count;
			$ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);
		
			$user->rating = $ratings;
	
		}

		return $chatSession;
	}

	public function signup(Request $request){
		$thisClient = json_decode($request->thisClient, false);

		$client = new Client;
		$client->name = $thisClient->name;
		$client->uid = $thisClient->uid;
		$client->business_name = $thisClient->business_name;
		$client->email = $thisClient->email;
		$client->contact_number = $thisClient->contact_number;
		$client->password = $thisClient->password;
		$client->save();

		return $client;
	}

	public function campaign_list(Request $request){
		$client = $request->user();
		$campaigns = new stdClass;

		$socialmedia = $client->socialmedia;
		foreach($socialmedia as $sma) {
			$sma->media;
			$sma->type = 1;
			
			foreach($sma->users as $user){
				$user->profile->media;
				$user->profile->socialMedia;
				$ratings = new stdClass();
				$ratings->total = 10;
				$ratings->count = 100;
				$ratings->average = 5;
			
				$user->profile->rating = $ratings;
			}
		}
		$events = $client->events;
		foreach($events as $event) {
			$event->media;
			$event->type = 2;
			foreach($event->applicants as $user){
				$user->profile;
				$ratings = new stdClass();
				$ratings->total = 10;
				$ratings->count = 100;
				$ratings->average = 5;
			
				$user->profile->rating = $ratings;
			}
			$event->users = $event->applicants;
		}
		$campaigns->socialmedia = $socialmedia;
		$campaigns->events = $events;

		return response()->json($campaigns);
	}

	public function campaign_user_list(Request $request){
		$campaign = null;

		if($request->campaign_type == 'Social Media') {
			$campaign = SocialMedia::find($request->campaign_id);
			$campaign->users;
		} elseif($request->campaign_type == 'Events') {
			$campaign = Event::find($request->campaign_id);
			$campaign->applcants;
		}
		
		return $campaign;
	}

	public function chat_messages(Request $request){
		$chat = Chat::where('session_id',$request->session_id)->get();
		return $chat;
	}

	public function chat_send(Request $request){
		$notification = new NotificationController();
		$client = Client::find($request->user()->id);
		$user = User::find($request->user_id);

		if($request->session_id === null) {
			$chatSession = new ChatSession;
			$chatSession->user_id = $request->user_id;
			$chatSession->client_id = $request->user()->id;
			$chatSession->campaign_type = $request->campaign_type;
			$chatSession->campaign_id = $request->campaign_id;
			$chatSession->client_read = 1;
			$chatSession->user_read = 0;
			$chatSession->new_message = $request->message;;
			$chatSession->new_message_from = 1;
			$chatSession->save();

		} else {
			$chatSession = ChatSession::find($request->session_id);
			$chatSession->new_message = $request->message;
			$chatSession->user_read = 0;
			$chatSession->client_read = 1;
			$chatSession->new_message_from = 1;
			$chatSession->save();
		}


		$chat = new Chat;
		$chat->session_id = $chatSession->id;
		$chat->client_id = $request->user()->id;
		$chat->user_id = $request->user_id;
		$chat->campaign_type = $request->campaign_type;
		$chat->campaign_id = $request->campaign_id;
		$chat->type = $request->type;
		$chat->sender = $request->sender;
		$chat->message = $request->message;
		$chat->attachment = null;
		$chat->save();
		
		

		broadcast(new \App\Events\ChatEvent($chatSession->id));

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
			'session' => $chatSession,
			'error' => $error
		]);
	}

	public function chat_delete(Request $request){
		$chat = Chat::find($request->chat_id);
		$chat->isDelete = 1;
		$chat->save();
		broadcast(new \App\Events\ChatEvent($chat->session_id, 'forDelete', $chat->id));
	}

	
}
