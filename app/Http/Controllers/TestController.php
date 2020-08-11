<?php

namespace App\Http\Controllers;

use Image;
use Storage;
use Mail;

use App\Media;
use Illuminate\Http\Request;

class TestController extends Controller
{
    public function ImageUpload(Request $request) {
        $img = $request->file('image');
        $media = new Media;
        $extension = $img->extension();

        if( $extension ==='mp4' || $extension ==='webm' || $extension ==='avi') {
            $type = 1;
        } else {
            $type = 0;
        }

        $media->owner = 99;
        $media->owner_id = 99;
        $media->holder = 99;
        $media->holder_id = 99;
        
        $media->extension = $extension;
        $media->type = $type;
        $media->save();
        
        $media->filename = $media->owner . '_' . $media->owner_id . '_' . $media->id . '.' . $media->extension;
        $media->url = 'media/test/' . $media->filename;

        $img_thumb = Image::make($img->getRealPath());
        $img_thumb->resize(300, null, function ($constraint) {
            $constraint->aspectRatio();
        });
        $img_thumb->encode('jpg',80);
        $img_thumbfilename = 'thumb_' . $media->filename;

        Storage::disk('public')->put( 'media/test/'.$img_thumbfilename, $img_thumb);
        $file = $img->storeAs('/media/test/',$media->filename, 'public');
        $media->save();
    }

    public function mail(Request $request){
		$email = 'ericreforma@gmail.com';

		Mail::send('mail.verificationCode',['verification_code'=> '111'], function ($message) use ($email){
			$message->from('no-reply@thehatchery.app', 'Hatchery');
			$message->replyto('no-reply@thehatchery.app', 'Hatchery');
			$message->subject("[Hatchery] Verification Code");
			$message->to('ericreforma@gmail.com');
        });
        
	}
}
