<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Client;
use App\Category;
use App\UserCategory;
use App\UserSocialMediaCampaign;
use App\SocialMedia;
use App\Status;
use App\Media;
use App\Vehicle;
use App\UserRating;
use App\Post;
use App\PostSMA;
use App\Event;
use App\EventApplicants;
use App\PostOnline;
use DB;
use Carbon\Carbon;
use stdClass;
use Image;
use Storage;

class UserSocialMediaController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */

    public function __construct()  {
        $this->middleware('auth:api');
    }

    private function saveMedia($owner_id, $holder_id, $file, $directory) {
        $mediaType = explode('/', $file->getMimeType())[0];

        $media = new Media;
        $media->owner = 0;
        $media->owner_id = $owner_id;
        $media->holder = 4;
        $media->holder_id = $holder_id;


        $media->type = $mediaType === 'image' ? 0 : 1;

        $media->file_type =$file->getMimeType();
        $media->extension =$file->extension();
        $media->save();
    
        $media->filename = $media->owner . '_' . $media->owner_id . '_' . $media->id . '.' . $media->extension;
        
        $img_thumb = Image::make($file->getRealPath());
        $img_thumb->resize(300, null, function ($constraint) {
            $constraint->aspectRatio();
        });
        $img_thumb->encode('jpg',80);
        $img_thumbfilename = 'thumb_' . $media->filename;
        Storage::disk('public')->put( 'media/user/'.$img_thumbfilename, $img_thumb);

        
        $media->url = 'media/user/' . $media->filename;
        $media->url_thumb = 'media/user/' .$img_thumbfilename;
        $file = $file->storeAs('/media/user', $media->filename, $directory);
        
        $media->save();
    
        return $media->id;
    }
    
    public function post_add(Request $request){
        $user = User::where('uid', $request->uid)->first();
    
        // USER SOCIAL MEDIA CAMPAIGN
            $userCampaign = UserSocialMediaCampaign::
                where('social_media_id','=',$request->social_media_id)
                ->where('user_id','=',$user->id);

            if($userCampaign->count() == 0){
                $user_campaign = new UserSocialMediaCampaign;
                $user_campaign->user_id = $user->id;
                $user_campaign->client_id = $request->client_id;
                $user_campaign->social_media_id = $request->social_media_id;
                $user_campaign->save();
            } else {
                $user_campaign = UserSocialMediaCampaign::find($userCampaign->select('id')->first()->id);
            }

        // ADD CAMPAIGN STATUS
            $status = new Status;
            $status->type = 1;
            $status->source = 1;
            $status->source_id = $request->social_media_id;
            $status->status = 'PENDING';
            $status->save();

            $user_campaign->status_id = $status->id;
            $user_campaign->status = $status->status;
            $user_campaign->save();

        // NEW POST
            $post = new Post;
            $post->user_id = $user->id;
            $post->client_id = $request->client_id;
            $post->social_media_id = $request->social_media_id;
            $post->user_sm_campaign_id = $user_campaign->id;

            $post->title = ' ';
            $post->caption = $request->caption;
            $post->tags = $request->tags;
            $post->version = $request->version ? $request->version : 1;
            $post->post_origin_id = $request->post_origin_id;

            $post->save();
            
            // ADD CAMPAIGN STATUS
                $post_status = new Status;
                $post_status->type = 1;
                $post_status->source = 4;
                $post_status->source_id = $post->id;
                $post_status->status = 'PENDING';
                $post_status->save();
            
            // PLATFORMS
                $platforms = json_decode($request->platforms, false);
                foreach($platforms as $sma){
                    $post_platform = new PostSMA;
                    $post_platform->post_id = $post->id;
                    $post_platform->sma_id = $sma;
                    $post_platform->save();
                }

            $post->status_id = $post_status->id;
            $post->status = $post_status->status;

            foreach($request->file('media') as $index => $img){
                $post->media_id = $this->saveMedia($user->id, $post->id, $img, 'public');
            }
            
            $post->save();
        
            return response()->json($post);
    }
    
    public function post_details(Request $request){
        $post = Post::find($request->id); 
        $post->media;
        $post->sma;
        $post->campaign->sma;
        
        
        return $post;
    }

    public function post_update(Request $request) {
        $user = User::where('uid', $request->uid)->first();
        $post = Post::find($request->post_id);
        
        $post->caption = $request->caption;
        $post->tags = $request->tags;
        $post->version = $post->version + 1;

        // PLATFORMS
        $platforms = json_decode($request->platforms, false);
        $deletedSMA = PostSMA::where('post_id',$post->id)->delete();

        foreach($platforms as $sma){
            $post_platform = new PostSMA;
            $post_platform->post_id = $post->id;
            $post_platform->sma_id = $sma;
            $post_platform->save();
        }

        // IMAGES
        if($request->has('oldMedia')){
            $oldMedia = json_decode($request->oldMedia, false);
            foreach($oldMedia as $oldimg){
                if (isset($oldimg->willDelete)) {
                    $deletedMedia = Media::find($oldimg->id)->delete();
                }
            }
        }

        if($request->has('newMedia')){
            foreach($request->file('newMedia') as $index => $img){
                $this->saveMedia($user->id, $post->id, $img, 'public');
            }
        }
        $post->save();
    }
        
    public function post_cancel(Request $request) {
        $post = Post::find($request->post_id);
        
        // ADD CAMPAIGN STATUS
            $post_status = new Status;
            $post_status->type = 1;
            $post_status->source = 4;
            $post_status->source_id = $post->id;
            $post_status->status = 'CANCELLED';
            $post_status->save();

        $post->status_id = $post_status->id;
        $post->status = $post_status->status;
        $post->save();
    }

    public function post_live_submit(Request $request){
        $user = User::where('uid', $request->uid)->first();
        $post = Post::find($request->post_id);
        
        $postid = $request->post_id;

        // ADD CAMPAIGN STATUS
            $postStatus = new Status;
            $postStatus->type = 1;
            $postStatus->source = 4;
            $postStatus->source_id = $postid;
            $postStatus->status = 'VERIFICATION';
            $postStatus->save();

        $post->status_id = $postStatus->id;
            $post->status = $postStatus->status;
            $post->save();

        $postOnline = new PostOnline;
        $postOnline->post_id = $post->id;
        $postOnline->campaign_id = $post->social_media_id;
        $postOnline->user_id = $user->id;
        $postOnline->client_id = $post->client_id;
        $postOnline->sma_type = $request->sma_type;
        $postOnline->sma = $request->sma;
        $postOnline->online_user_id = $request->online_user_id;
        $postOnline->online_user_photo = $request->online_user_photo;
        $postOnline->online_user_name = $request->online_user_name;
        $postOnline->online_post_id = $request->online_post_id;
        $postOnline->online_post_caption = $request->online_post_caption;
        $postOnline->online_post_media = $request->online_post_media;
        $postOnline->online_post_likes = $request->online_post_likes;
        $postOnline->online_post_comments = $request->online_post_comments;
        $postOnline->online_post_shares = $request->online_post_shares;
        $postOnline->online_post_timestamp = $request->online_post_timestamp;
        $postOnline->online_post_permalink = $request->online_post_permalink;
        $postOnline->save();
    }

    public function post_setFeatured(Request $request) {
        $postOnline = PostOnline::find($request->postOnline_id);
        $postOnline->isFeatured = 1;
        $postOnline->save();

    }
}