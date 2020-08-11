<?php

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

Broadcast::channel('client.{id}', function ($client, $id) {
    return (int) $client->id === (int) $id;
}, ['guards' => ['web_api']]);

Broadcast::channel('user.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
}, ['guards' => ['api']]);

Broadcast::channel('chat.{id}', function ($chat, $id) {
    return (int) $chat->id === (int) $id;
});

Broadcast::channel('notification.{id}', function ($notification, $id) {
    return (int) $notification->id === (int) $id;
});