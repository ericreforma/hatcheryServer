import React, { useEffect, useReducer, useContext, useState, useCallback } from 'react';
import firebase from 'firebase/app';
import 'firebase/firestore';
import 'firebase/auth';
import COOKIE from '../../config/cookies';
import Message from './Message';
import URL from '../../config/url';

import { messagesReducer } from './reducers';

const ChatApp = props => {
  const uid = COOKIE.uid();
  const [session_id, setSessionId] = useState(props.receiver.id);
  const [messages, dispatchMessages] = useReducer(messagesReducer, [])
  const [message, setMessage] = useState('');
  const messageRef = firebase.firestore().collection('messages');
  const [toggleHead, setToggleHead] = useState(false);

  useEffect( () => 
    dispatchMessages({ type: 'reset', payload: [] }),
    [props.receiver.id]
  );

  useEffect( () => 
    firebase.firestore().collection('messages')
    .where('session_id', '==', props.receiver.id)
    .orderBy('created_at', 'asc')
    .onSnapshot(function (snapshot) {
      dispatchMessages({ type: 'add', payload: snapshot.docs })
    }),
    [props.receiver.id]
  );

  const handlePress = useCallback(
    () => {
      messageRef.add({
        session_id: props.receiver.id,
        message,
        uid: uid,
        created_at: new Date()
      }).then(() => {
        setMessage('');
      })
    },
    [message]
  );

  return (
    <div className='chat_app'>
        <div className='chat_message_wrapper'  style={{ height: props.height - 200 }}>
          {messages && messages.map((msg, index) => 
              <Message 
                side={`${msg.data().uid === uid ? 'right' : 'left'}`} 
                message={msg.data().message} 
                time={msg.data().created_at}
                key={index}
              />
                
          )}
        </div>

        <div className="chat_input_container">
          <input 
            id={`${props.receiver.user_uid}_input`} 
            type="text" value={message} 
            onChange={e => {setMessage(e.target.value)}} 
            placeholder='Write your message' 
            onKeyDown={e => {
              if(e.key === 'Enter'){
                handlePress()
              }
            }}
          />
        </div>
      </div>
  );
}

export default ChatApp;