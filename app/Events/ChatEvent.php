<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use App\Chat;

class ChatEvent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    public $chat_id;
    public $session_id;
    public $type;
    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($session_id, $type = 'new', $chat_id = null)
    {
        $this->session_id = $session_id;
        $this->chat_id = $chat_id;
        $this->type = $type;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new Channel('chat.'.$this->session_id);
    }

    public function broadcastWith()
    {
        if($this->type == 'new') {
            $message = Chat::where('session_id', $this->session_id)
                ->orderBy('created_at', 'desc')
                ->first();
        } else if($this->type == 'forDelete'){
            $message = Chat::find($this->chat_id);
        }
       
        
        return ['chat' => $message, 'type' => $this->type];
    }
}
