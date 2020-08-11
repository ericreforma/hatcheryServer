<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Kreait\Firebase;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Notifications;
use App\User;

class NotificationController extends Controller
{   
    public function get(Request $request){
        
        $user = User::where('uid', $request->uid)->first();
        return response()->json(['all' => $user->notifications, 'unread' => $user->unreadNotifications]);
    }

    public function opened(Request $request){
        $notif = Notifications::find($request->notification_id);
        $notif->isOpened = 1;
        $notif->save();
    }
    
    public function create(Request $request) {
        $notif = new Notifications;
        $notif->user_type = $request->user_type;
        $notif->from_id = $request->from_id;
        $notif->to_id = $request->to_id;
        $notif->type = $request->type;
        $notif->message = $request->message;
        $notif->save();
    }

    public function test(Request $request) {
        $title = 'test title';
        $body = 'test body';
        $image = null;

        $token = $request->token;

        $this->notify_device($title, $body, $image, $token);

        broadcast(new \App\Events\NotificationEvent($request->user_id));
        return response()->json(['test' => 'suces']);
    }

    public function notify_device($title, $body, $image, $token){
        $messaging = (new Firebase\Factory())
        ->withServiceAccount('../influencerapp-872a0-firebase-adminsdk-7msh9-4f96fa86a8.json')
        ->withDisabledAutoDiscovery()
        ->createMessaging();

        $notification = Notification::fromArray([
            'title' => $title,
            'body' => $body,
            'image' => $image
        ]);

        $message = CloudMessage::withTarget('token', $token)
            ->withNotification($notification);

        $messaging->send($message);
    }   
    
}
