<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\SocialMedia;
use App\SocialMediaIncentives;
use App\SocialMediaTag;
use App\UserRating;
use App\UserSocialMediaCampaign;
use App\Media;
use App\Client;
use App\User;
use App\UserEvent;
use App\Event;
use App\EventJobs;
use App\EventSchedule;
use App\EventApplicants;
use App\Jobs;
use App\Status;
use DB;
use stdClass;

class CampaignController extends Controller
{
	public function __construct() {
		$this->middleware('auth:api');
	}
	
	private function user($uid){
        $thisUser = User::where('uid', $uid)->first();
        $user = User::find($thisUser->id);
        return $user;
	}
	
	public function browse(Request $request){
		$campaign = new stdClass;

		$campaign->recommended = $this->browseCampaign(0);
		$campaign->online = $this->browseCampaign(1);
		$campaign->events = $this->browseCampaign(2);

		return response()->json($campaign);
	}

	private function browseCampaign($campaign_type){
		if($campaign_type == 0) {
			$campaign = SocialMedia::with('sma')->with('client')->with('media');
				
		} else if($campaign_type == 1) {
			$campaign = SocialMedia::with('sma')->with('client')->with('media');
			$campaign->type = 1;
		} else if($campaign_type == 2) {
			$campaign = Event::with('jobs')->with('client')->with('media')->with('schedule');
			$campaign->type = 2;
		}
		return $campaign->inRandomOrder()->limit(5)->get();
	}
	
	public function my_list(Request $request){
		$user = User::where('uid', $request->uid)->first();
		$interested = [];

		$socialMedia = new stdClass;
		$socialMedia->interested = [];
		$socialMedia->posts = [];

		$mySocialmedia = $user->socialMediaCampaigns;
		$posts = $user->posts;

		foreach($mySocialmedia as $c){
			if($c->status == 'INTERESTED'){
				$c->parentCampaign;
				$c->parentCampaign->sma;
				$c->parentCampaign->tags;
				$c->parentCampaign->media;
				$c->parentCampaign->client->media;
				
				array_push($interested, $c);
			}
		}

		$socialMedia->interested = $interested;

		foreach($posts as $p){
			$p->campaign;
			
			$p->campaign->sma;
			$p->campaign->tags;
			$p->campaign->media;
			$p->client->media;

			$p->media;
			$p->mediaCollection;
			$p->sma;
			$p->online;
		}
		
		$socialMedia->posts = $posts;

		$events = new stdClass;
		$events->interested = [];
		$events->pending = [];
		$events->accepted = [];
		$events->completed = [];

		$myevent = DB::table('event_applicants')
			->where('user_id',$user->id)
			->groupBy('event_id')
			->get();

		// PENDING
		foreach($myevent as $e) {
			$theEvent = Event::find($e->event_id);
			$theEvent->client->media;
			$theEvent->event;
			$theEvent->media;

			$pending = EventApplicants::
				where('user_id', $user->id)->
				where('event_id', $theEvent->id)->
				where('status','PENDING')
				->with('job')
				->get();
			
			$accepted = EventApplicants::
				where('user_id', $user->id)->
				where('event_id', $theEvent->id)->
				where('status','ACCEPTED')
				->with('job')
				->get();

			$completed = EventApplicants::
				where('user_id', $user->id)->
				where('event_id', $theEvent->id)->
				where('status','COMPLETED')
				->with('job')
				->get();

			if(count($pending)){
				$theEvent->jobsApplied = $pending;
				array_push($events->pending, $theEvent);
			}

			if(count($completed)){
				$theEvent->jobsApplied = $completed;
				array_push($events->completed, $theEvent);
			}

			if(count($accepted)){
				$theEvent->jobsApplied = $accepted;
				array_push($events->accepted, $theEvent);
			}
		}

		
		return response()->json(['socialMedia' => $socialMedia, 'events' => $events]);
	}

	public function interested(Request $request){ 
		$user = User::where('uid', $request->uid)->first();
		$campaign = new UserSocialMediaCampaign;
		$campaign->user_id = $user->id;
		$campaign->social_media_id = $request->social_media_id;
		$campaign->client_id = $request->client_id;
		$campaign->save();
	
		// ADD STATUS
			$status = new Status;
			$status->type = 1;
			$status->source = 1;
			$status->source_id = $request->social_media_id;
			$status->status = 'INTERESTED';
			$status->save();
		
			$campaign->status = $status->status;
			$campaign->status_id = $status->id;
			$campaign->save();

		return response()->json(['message' => 'success']);
	}

	public function removeInterested(Request $request){
		UserSocialMediaCampaign::find($request->campaign_id)->delete();
	}
	
	public function campaign_store(Request $request){
		$campaign = new Campaign;
	}

	public function campaign_details(Request $request){
		$campaign = null;
		$user = User::where('uid', $request->uid)->first();
		if($request->type == 1) {
			$campaign = SocialMedia::find($request->id);
			$campaign->tags;
			$campaign->sma;
			$campaign->media;
			$campaign->budgets;
			
			$userStatus = UserSocialMediaCampaign::
				select('status')->
				where('user_id', $user->id)->
				where('social_media_id', $campaign->id)->
				first();

			if($userStatus === NULL) {
				$campaign->userStatus = null;
			} else {
				$campaign->userStatus = $userStatus->status;
			}
		} else {
			$applicationStatus  = EventApplicants::
				where('user_id', $user->id)->
				where('event_id', $request->id)->get();
				

			$campaign = Event::find($request->id);
			$campaign->schedule;
			foreach($campaign->jobs as $jobs) {
				$jobs->schedule;
				$jobs->skills;
			}
			$campaign->applicationStatus = $applicationStatus;
			
		}
		
		$campaign->client;
		$campaign->media;
		return $campaign;
	}

	public function viewall(Request $request) {
		if($request->type == 0) {
			$campaigns = SocialMedia::with('sma')
				->with('client')
				->with('media')
				->orderBy('created_at','desc')->get();
		}
		else if($request->type == 1) {
			$campaigns = SocialMedia::with('sma')
				->with('client')
				->with('media')
				->orderBy('created_at','desc')->get();
				
		} else if($request->type == 2) {
			$campaigns = Event::with('jobs')->with('client')->with('media')->with('schedule')->orderBy('created_at','desc')->get();
		}

	
		return $campaigns;
	}
}
