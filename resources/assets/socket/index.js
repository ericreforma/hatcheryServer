import Echo from 'laravel-echo'
import COOKIE from '../config/cookies';

const socket = {
    init: (id) => {
        const token = COOKIE.token();
        window.io = require('socket.io-client');
        window.Echo = new Echo({
            authEndpoint : `${window.location.hostname}/influencer/public/broadcasting/auth`,
            broadcaster: 'socket.io',
            host: window.location.hostname + ':6001',
            auth: {headers: {Authorization: `Bearer ${token}`}}
        });

        window.Echo.private(`client.${id}`)
        .listen('ClientEvent', (e) => {
            console.log(e);
        });

    },
    chat: (session_id, callback) => {
        window.Echo.channel(`chat.${session_id}`)
        .listen('ChatEvent', (e) => {
            callback(e);
        });
    },
    leaveChat: session_id => {
        window.Echo.leaveChannel(`chat.${session_id}`);
    }

}

export default socket;