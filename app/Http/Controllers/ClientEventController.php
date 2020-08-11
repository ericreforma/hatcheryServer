<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

use Illuminate\Http\Request;
use App\User;
use App\Event;
use App\EventJobs;
use App\EventJobSkills;
use App\EventSchedule;
use App\EventApplicants;
use App\EventJobSchedule;
use App\Client;
use App\Media;
use App\Status;
use App\UserEvent;
use App\Notifications;
use DB;
use Carbon\Carbon;
use Image;
use stdClass;

class ClientEventController extends Controller
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
	  
		$ratings->total = $ratings_sum;
		$ratings->count = $ratings_count;
		$ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);
	
		$user->rating = $ratings;
		$user->socialMedia;
		$user->category;
		return $user;
	}

    public function publish(Request $request) {
		$event = new Event;
		
		// GET FORM content
			$client = $request->user();
			$content = json_decode($request->content, false);
			$jobs = json_decode($request->jobs, false);
			$scheduling = json_decode($request->scheduling, false);

		// SAVE EVENT
			$event->client_id = $client->id;
			$event->name = $content->name;
			$event->description = $content->description;
			$event->days_total = $content->days_total;
			$event->hours_total = $content->hours_total;
			$event->venue = $content->venue;
			$event->venue_address = $content->venue_address;
			$event->est_audience = $content->est_audience;

			$event->save();

		//  STATUS
			$status = new Status;
			$status->type = 1;
			$status->source = 2;
			$status->source_id = $event->id;
			$status->status = 'POSTED';
			$status->remarks = '';
			$status->save();

			$event->status = $status->status;
			$event->status_id = $status->id;
			$event->save();

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
				$media->holder = 3;
				$media->holder_id = $event->id;
				$media->type = $type;
				$media->extension = $img->extension();
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
			
		// SAVE MEDIA content TO THE EVENT
			$event->media_id = $mediaId[0];
			$event->save();
			
		// SCHEDULING
			foreach($content->schedule as $sched){
				$schedule = new EventSchedule;
				$schedule->event_id = $event->id;
				$schedule->date_from = $sched->from;
				$schedule->date_to = $sched->to;
				$schedule->breaktime = $sched->breaktime;
				$schedule->workhours = $sched->workhours;
				$schedule->save();
			}

		// JOBS
			foreach($jobs as $jobCosting){
				$job = new EventJobs;
				$job->event_id = $event->id;
				$job->client_id = $client->id;
				$job->job_id = $jobCosting->id;
				$job->job_description = $jobCosting->description;
				$job->quantity = $jobCosting->quantity;
				$job->rate = $jobCosting->rate;
				$job->rate_unit = $jobCosting->rate_unit;
				$job->save();

				foreach($jobCosting->skills as $jobskill){
					$skill = new EventJobSkills;
					$skill->eventjob_id = $job->id;
					$skill->client_id = $client->id;
					$skill->event_id = $event->id;
					$skill->job_id = $job->job_id;
					$skill->skill_id = $jobskill->id;
					$skill->skill_description = $jobskill->description;
					$skill->save();
				}

				// JOb Schedule
				foreach($scheduling->jobSchedule as $schedulingJob) {
					if($job->job_id == $schedulingJob->job_id) {
						$jobSchedule = new EventJobSchedule;
						$jobSchedule->eventjob_id = $job->id;
						$jobSchedule->event_id = $event->id;
						$jobSchedule->client_id = $client->id;
						$jobSchedule->job_id = $schedulingJob->job_id;
						$jobSchedule->job_description = $schedulingJob->job_description;
						$jobSchedule->schedule_date = $schedulingJob->schedule_date;
						$jobSchedule->schedule_from = $schedulingJob->schedule_from;
						$jobSchedule->schedule_to = $schedulingJob->schedule_to;
						$jobSchedule->breaktime = $schedulingJob->schedule_breaktime;
						$jobSchedule->workhours = $schedulingJob->schedule_workhours;
						$jobSchedule->rate = $schedulingJob->schedule_rate;
						$jobSchedule->isRemoved = $schedulingJob->isRemoved;
						$jobSchedule->save();
					}

				}
			}
		
		

		return response()->json(['message' => 'success']);
    }
    
    public function list(Request $request){
		$user = $request->user();

		$event = $user->events()
					->with('media')
					->with('applicants')
					->latest()->paginate(4);

		return response()->json($event);
	}
	
	public function details($id){
		$event = Event::find($id);
		
		if($event != null){
			$event->media;
			foreach($event->jobs as $job){
				$job->skills;
			}
			$event->schedule;

			foreach($event->applicants as $applicant){
				$ratings = new stdClass();
				$ratings_count = 0;
				$ratings_sum = 0;

				$profile = User::find($applicant->user_id);
				$media = Media::where('owner',0)
							->where('owner_id',$profile->id)
							->first();

				$profile->media = $media;

				$applicant->job = EventJobs::find($applicant->eventjob_id);
				$applicant->profile = $profile;

				// Ratings
				foreach($profile->ratings as $r){
					$ratings_count += 1;
					$ratings_sum += $r->rate;
				}
			
				$ratings->total = $ratings_sum;
				$ratings->count = $ratings_count;
				$ratings->average = ($ratings_count == 0) ? 0 : round(($ratings_sum / $ratings_count), 1);
			
				$applicant->profile->rating = $ratings;
			}

			$status = DB::table('status')
				->select('id', 'status','remarks','created_at')
				->where('type',1)
				->where('source',2)
				->where('source_id', $event->id)
				->get();

			$event->statusHistory = $status;
		}
		return response()->json($event);
	}

	public function applicant_profile(Request $request){
		$profile = $this->user_profile($request->user_id);
		$jobEvent = EventJobs::find($request->eventjob_id);
		$jobApplication = EventApplicants::find($request->event_applicant_id);

		return response()->json(['jobApplication' => $jobApplication, 'profile' =>  $profile, 'eventjob' => $jobEvent]) ;
	}

	public function applicant_setStatus(Request $request){
		
		$notification = new NotificationController();
		$eventApplicant = EventApplicants::find($request->event_applicant_id);
		$client = Client::find($eventApplicant->client_id);
		$user = User::find($eventApplicant->user_id);

		$newStatus = new Status;
		$newStatus->type = 3;
		$newStatus->source = 1;
		$newStatus->source_id = $request->event_applicant_id;
		$newStatus->status = $request->status;
		$newStatus->save();

		$eventApplicant->status_id = $newStatus->id;
		$eventApplicant->status = $newStatus->status;
		$eventApplicant->save();

		$notif = new Notifications;
        $notif->user_type = 0;
        $notif->from_id = $client->id;
		$notif->to_id = $eventApplicant->user_id;
		$notif->from_name = $client->business_name;
        $notif->type = 1;
        $notif->message = strtolower($newStatus->status) . ' your application';
		$notif->save();

		$title = 'Your post ' . $newStatus->status;
		$body = $request->user()->business_name . ' ' . $newStatus->status . ' your application.';
		$notification->notify_device($title, $body, null, $user->fcm_token);
		broadcast(new \App\Events\NotificationEvent($eventApplicant->user_id));
		
		return response()->json('success');
	}

	public function job_list(Request $request){
		$jobs = EventJobs::where('event_id', $request->event_id)
				->with('applicants')
				->with('skills')
				->get();

		return $jobs;
	}

	public function job_skill(Request $request){

	}
}