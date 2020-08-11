<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Event;
use App\EventJobs;
use App\EventApplicants;
use App\EventJobSchedule;
use App\EventApplicantSchedule;
use App\Status;

class UserEventController extends Controller
{
    public function applicationSubmit(Request $request) {
        $user = User::where('uid', $request->uid)->first();

        $job_selected = json_decode($request->job_selected, false);
        $job_schedule_selected = json_decode($request->jobs_schedule_selected, false);
        
        foreach($job_selected as $job){
            $eventjob  = EventJobs::find($job);

            $applicant = new EventApplicants;
            $applicant->user_id = $user->id;
            $applicant->client_id = $eventjob->client_id;
            $applicant->event_id =  $eventjob->event_id;
            $applicant->eventjob_id =  $eventjob->id;
            $applicant->job_id = $eventjob->job_id;
            $applicant->job_description = $eventjob->job_description;
            $applicant->save();

            $status = new Status;
            $status->type = 3;
            $status->source = 1;
            $status->source_id = $applicant->id;
            $status->status = 'PENDING';
            $status->save();

            $applicant->status_id = $status->id;
            $applicant->status = $status->status;
            $applicant->save();

            foreach($job_schedule_selected as $sched) {
                if($sched->job_id == $applicant->job_id) {
                    $eventsched = new EventApplicantSchedule;
                    $eventsched->eventapplicant_id = $applicant->id;
                    $eventsched->eventjobschedule_id = $sched->id;
                    $eventsched->client_id = $sched->client_id;
                    $eventsched->user_id = $user->id;
                    $eventsched->event_id = $sched->event_id;
                    $eventsched->eventjob_id = $sched->eventjob_id;
                    $eventsched->job_id = $sched->job_id;
                    $eventsched->job_description = $sched->job_description;
                    $eventsched->schedule_date = $sched->schedule_date;
                    $eventsched->schedule_from = $sched->schedule_from;
                    $eventsched->schedule_to = $sched->schedule_to;
                    $eventsched->workhours = $sched->workhours;
                    $eventsched->breaktime = $sched->breaktime;
                    $eventsched->rate = $sched->rate;
                    $eventsched->save();
                }
            }
        }
        
		return response()->json(['data' => 'success']);
    }
}
