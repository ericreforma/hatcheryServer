<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

use App\SocialMedia;
use App\SocialMediaTag;
use App\SocialMediaBudget;
use App\SocialMediaCategory;
use App\Client;
use App\User;
use App\Post;
use App\PostOnline;
use App\UserInterested;
use App\Media;
use App\Status;
use App\SocialMediaSM;
use App\Notifications;
use App\UserSocialMediaCampaign;
use App\Http\Controllers\NotificationController;
use Image;
use DB;
use stdClass;
use Exception;

use Carbon\Carbon;
class ClientSocialMediaController extends Controller
{
    /**
	 * Create a new controller instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$this->middleware('auth:web_api');
	}

	/** 
	 * Show the application dashboard.
	 *
	 * @return \Illuminate\Contracts\Support\Renderable
	 */

	private function user($uid){
		$thisUser = Client::where('uid', $uid)->first();
		$user = Client::find($thisUser->id);
		return $user;
	}

	private function user_profile($id){
		$ratings = new stdClass();
		$ratings_count = 0;
		$ratings_sum = 0;
		
		$user = User::find($id);
		$user->media;

		// Ratings
		foreach($user->ratings as $r){
			$ratings_count += 1;
			$ratings_sum += $r->rate;
			
			$r->client_name = Client::find($r->client_id)->name;
			$r->client_media = Client::find($r->client_id)->media;
		}
	  
		// $ratings->total = $ratings_sum;
		// $ratings->count = $ratings_count;
		// $ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);

		$ratings->total = 10;
		$ratings->count = 100;
		$ratings->average = 5;

		$user->rating = $ratings;
		$user->socialMedia;
		$user->category;
		return $user;
	}

	private function user_rating($id){
		$user = User::find($id);

		$name = $user->name;
		$media = $user->media;
		
		$ratings = new stdClass();
		$ratings_count = 0;
		$ratings_sum = 0;
		
		
		// Ratings
		foreach($user->ratings as $r){
			$ratings_count += 1;
			$ratings_sum += $r->rate;
			
			$r->client_name = Client::find($r->client_id)->name;
			$r->client_media = Client::find($r->client_id)->media;
		}
	  
		$ratings->total = $ratings_sum;
		$ratings->count = $ratings_count;
		$ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);
		
		$u = new stdClass;
		$u->id = $user->id;
		$u->name = $name;
		$u->media = $media;
		$u->ratings = $ratings;

		return $u;
	}

    public function publish(Request $request){
		$socialmedia = new SocialMedia;
		$media = new Media;
		
		// GET FORM CONTENT
			$client = $request->user();
			$content = json_decode($request->content, false);
			$budget = json_decode($request->budget, false);

		// SAVE CAMPAIGN
			$socialmedia->client_id = $client->id;
			$socialmedia->name = $content->name;

			$socialmedia->description = $content->description;
			$socialmedia->gender = $content->gender;
			$socialmedia->followers = $content->followers;
			$socialmedia->deadline = Carbon::parse($content->deadline,'Asia/Manila')->format('Y-m-d H:i:s');
			$socialmedia->age_from = $content->age_range[0];
			$socialmedia->age_to = $content->age_range[1];
			$socialmedia->total_budget = $budget->budget;
			$socialmedia->collaborator_count = $budget->collaborator_count;
			$socialmedia->collaborator_budget = $budget->collaborator_budget;
			$socialmedia->engagement_budget = $budget->engagement_budget;
			$socialmedia->basic_pay = $budget->basic_pay;
			$socialmedia->duration_from = Carbon::parse($content->duration[0])->format('Y-m-d H:i:s');;
			$socialmedia->duration_to = Carbon::parse($content->duration[1])->format('Y-m-d H:i:s');;

			$socialmedia->save();

		// ADD STATUS
			$status = new Status;
			$status->type = 1;
			$status->source = 1;
			$status->source_id = $socialmedia->id;
			$status->status = 'POSTED';
			$status->save();

			$socialmedia->status = $status->status;
			$socialmedia->status_id = $status->id;
			$socialmedia->save();
			
		// SAVE SOCIAL MEDIA

			foreach($content->socialMedia as $sm) {
				$sma = new SocialMediaSM;
				$sma->social_media_id = $socialmedia->id;
				$sma->sm_id = $sm->id;
				$sma->sm_description = $sm->prettyname;
				$sma->save();
			}

		// SAVE MEDIA Files
			$images = $request->file('images');
			$mediaId = [];
			foreach($request->file('images') as $index => $img){
				$media = new Media;
				$extension = $img->extension();

				if( $extension ==='mp4' || $extension ==='webm' || $extension ==='avi') {
					$type = 1;
				} else {
					$type = 0;
				}

				$media->owner = 1;
				$media->owner_id = $client->id;
				$media->holder = 2;
				$media->holder_id = $socialmedia->id;
				
				$media->extension = $extension;
				$media->type = $type;
				$media->save();
				
				$media->filename = $media->owner . '_' . $media->owner_id . '_' . $media->id . '.' . $media->extension;
				$img_thumbfilename = 'thumb_' . $media->filename;
				$media->url = 'media/client/' . $media->filename;
				$media->url_thumb = 'media/client/' .$img_thumbfilename;

				$img_thumb = Image::make($img->getRealPath());
				$img_thumb->resize(300, null, function ($constraint) {
					$constraint->aspectRatio();
				});
				$img_thumb->encode('jpg',80);
				
				Storage::disk('public')->put( 'media/client/'.$img_thumbfilename, $img_thumb);

				$file = $img->storeAs('/media/client/',$media->filename, 'public');
				$media->save();

				array_push($mediaId, $media->id);
			}
			
		// SAVE MEDIA content TO THE SOCIAL MEDIA
			$socialmedia->media_id = $mediaId[0];
			$socialmedia->save();

		// CAMPAIGN CATEGORIES
			foreach($content->categories as $cc) {
				$socialmediaCategory = new SocialMediaCategory;
				$socialmediaCategory->social_media_id = $socialmedia->id;
				$socialmediaCategory->client_id = $client->id;
				$socialmediaCategory->category_id = $cc->id;
				$socialmediaCategory->description = $cc->description;
				$socialmediaCategory->save();
			}
			
		// SAVE TAGS - HASHTAGS
			foreach($content->hashtag as $hashtag){
				$hashtags = new SocialMediaTag;
				$hashtags->social_media_id = $socialmedia->id;
				$hashtags->type = 0;
				$hashtags->caption = $hashtag;
				$hashtags->save();
			}

		// SAVE TAGS - MENTIONS
			foreach($content->mentions as $mention){
				$mentions = new SocialMediaTag;
				$mentions->social_media_id = $socialmedia->id;
				$mentions->type = 1;
				$mentions->caption = $mention;
				$mentions->save();
			}
		
		// CLEAR INCENTIVES
			$engagement_types = ["likes", "comments", "shares", "views"];

			$i = 0;
			foreach($engagement_types as $type){
				if($budget->{$type . "_selected"}) {
					$socialmediabudget = new SocialMediaBudget;
					$socialmediabudget->client_id = $socialmedia->client_id;
					$socialmediabudget->social_media_id = $socialmedia->id;

					$socialmediabudget->engagement = $i;
					$socialmediabudget->min = $budget->{$type . "_min"};
					$socialmediabudget->max = $budget->{$type . "_max"};
					$socialmediabudget->quantity = $budget->{$type . "_quantity"};
					$socialmediabudget->per_unit = $budget->{$type . "_per_unit"};
					$socialmediabudget->cost = $budget->{$type . "_cost"};
	
					$socialmediabudget->save();
	
					$i++;
				}
			}
			
		return response()->json(['message' => 'success']);
    }

    public function list(Request $request){
		$user = $request->user();

		$socialmedia = $user->SocialMedia()
					->with('media')
					->with('tags')
					->with('sma')
					->with('posts')
					->latest()->paginate(4);

		return response()->json($socialmedia);
	}

	public function posts(Request $request){
		$socialMedia = SocialMedia::find($request->id);
		$posts = array();

		$status = [
			'PENDING',
			'INTERESTED',
			'APPROVED',
			'REJECTED',
			'VERIFICATION',
			'ACTIVE',
			'COMPLETED'
		];

		foreach($status as $stat){
			$user_list = array();
			$users = $socialMedia->posts()->select('user_id')->where('status',$stat)->groupBy('user_id')->get();

			foreach($users as $u){
				$user = $this->user_rating($u->user_id);
				$user->post_count = $socialMedia->posts()->select('user_id')->where('status',$stat)->where('user_id',$u->user_id)->count();
				array_push($user_list,$user);
			}
	
			$posts[$stat] = $user_list;
		}
		
		return $posts;
	}

	public function details($id){
		$socialMedia = SocialMedia::find($id);
		
		foreach($socialMedia->users as $users){
			$users->profile = $this->user_profile($users->user_id);
			$users->postCount = DB::table('post')->where('user_id',$users->id)
								->where('social_media_id',$id)->count();
		}

		$socialMedia->media;
		$socialMedia->budgets;
		$socialMedia->tags;
		$socialMedia->categories;

		return $socialMedia;
	}

	public function interested(Request $request){
		$count = UserSocialMediaCampaign::
			where('social_media_id',$request->social_media_id)
			->count();

		if($count == 0) {
			$userSocialmedia = new UserSocialMediaCampaign;
			$userSocialmedia->user_id = $request->user()->id;
			$userSocialmedia->social_media_id = $request->social_media_id;
			$userSocialmedia->client_id = $request->client_id;
			$userSocialmedia->save();

			// ADD STATUS
				$status = new Status;
				$status->type = 1;
				$status->source = 1;
				$status->source_id = $request->social_media_id;
				$status->status = 'INTERESTED';
				$status->save();

				$userSocialmedia->status = $status->status;
				$userSocialmedia->status_id = $status->id;
				$userSocialmedia->save();

			return response()->json(['message' => 'success']);
		}

		return response()->json(['message' => 'failed']);
	}

	public function user_posts(Request $request){

		$user = User::find($request->user_id);
		
		$user->posts = $user->posts()
				->where('social_media_id', $request->social_media_id)
				->where('status', $request->status)
				->with('media')
				->with('sma')
				->with('online')
				->get();

		$user->profile = $this->user_profile($user->id);

		return $user;
	}

	public function post_change_status(Request $request){
		$post = Post::find($request->post_id);
		$notification = new NotificationController();

		$user_socialMedia = UserSocialMediaCampaign::find($post->user_sm_campaign_id);
		$user_socialMedia->status = $request->status;
		$user_socialMedia->save();

		$status = new Status;
		$status->type = 1;
		$status->source = 4;
		$status->source_id = $post->id;
		$status->status = $request->status;
		$status->save();

		$post->status = $status->status;
		$post->status_id = $status->status_id;
		$post->save();

		$notif = new Notifications;
        $notif->user_type = 0;
        $notif->from_id = $post->client_id;
		$notif->to_id = $post->user_id;
		$notif->from_name = $user_socialMedia->client->business_name;
        $notif->type = 1;
        $notif->message = strtolower($status->status) . ' your post';
		$notif->save();

		$user = User::find($post->user_id);

		$title = 'Your post ' . $status->status;
		$body = $request->user()->business_name . ' ' . $status->status . ' your post.';
		broadcast(new \App\Events\NotificationEvent($post->user_id));
		try{
			$notification->notify_device($title, $body, null, $user->fcm_token);
		} catch(Throwable $e) {
			
		}
	}

	public function post_online_remove(Request $request){
		$post = Post::find($request->post_id);
		$notification = new NotificationController();

		$post_online = PostOnline::find($request->postOnline_id);
		$post_online->delete();

		$user_socialMedia = UserSocialMediaCampaign::find($post->user_sm_campaign_id);
		$user_socialMedia->status = $request->status;
		$user_socialMedia->save();

		$status = new Status;
		$status->type = 1;
		$status->source = 4;
		$status->source_id = $post->id;
		$status->status = $request->status;
		$status->save();

		$post->status = $status->status;
		$post->status_id = $status->status_id;
		$post->save();

		$notif = new Notifications;
        $notif->user_type = 0;
        $notif->from_id = $post->client_id;
		$notif->to_id = $post->user_id;
		$notif->from_name = $user_socialMedia->client->business_name;
        $notif->type = 1;
        $notif->message = 'declined your online post';
		$notif->save();

		$user = User::find($post->user_id);

		$title = 'Your post ' . $status->status;
		$body = $request->user()->business_name . ' declined your online post.';
		broadcast(new \App\Events\NotificationEvent($post->user_id));
		try{
			$notification->notify_device($title, $body, null, $user->fcm_token);
		} catch(Throwable $e) {
			
		}
		
		
	}

	public function user_list(Request $request){
		$client = $request->user();

		foreach($client->socialmedia as $sm){
			foreach($sm->users as $us){
				$us->profile->media;
			}
		};

		return $client;
	}
}
