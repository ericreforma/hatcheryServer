import React, { useEffect, useReducer, useContext, useState, useCallback, useRef } from 'react';
import Message from './Message';
import ContentEditable from 'react-contenteditable'
import { HttpRequest } from '../../functions/HttpService';
import URL from '../../config/url';

const ChatApp = props => {
  const [txt, setTxt] = useState('');
  const input = useRef(null);
  const chatContainerElement = useRef(null);
  const chatMessageElement = useRef(null);
  const [chatmessages, setMessages] = useState(props.messages);

  useEffect(() => {
    setMessages(props.messages);
  }, [props.messages]);

  useEffect(() => {
    chatContainerElement.current.scrollTo(0, chatMessageElement.current.clientHeight);
  });

  useEffect(() => {
    input.current = txt;
  }, [txt]);

  const sending = useCallback(() => {
    props.sendingMessageQueue(input.current);
    setTxt('');
  },[txt]);
  
  const onChange = useCallback (e => {
    setTxt(e.target.value);
  });

  return (
    <div className='chat_app'>
        {/* <div className='chat_profile_top'>
          <div className='chat_profile_top_photo'
              style={{backgroundImage: session.user.media ?
                  `url(${URL.SERVER_STORAGE}/${session.user.media.url})` :
                  `url(${URL.SERVER}/images/default_avatar.png)`}}>
          </div>
          <div className='chat_profile_top_name'>
                { session.user.name}
          </div>
        </div> */}
        <div className='chat_message_wrapper' ref={chatContainerElement}>
          <div className='chat_message_content' 
            id={'chat_message_content'}
            ref={chatMessageElement}
          >
            {props.messages.length === 0 ?
              <p className='chat_empty'>Send a message to start a conversation.</p>
            : props.messages.map((msg, index) => 
                <Message 
                  side={`${msg.sender === 1 ? 'right' : 'left'}`} 
                  status={msg.status}
                  message={msg.message} 
                  theTime={msg.created_at}
                  key={index}
                  onDelete={() => {
                    props.onDelete(msg.id);
                  }}
                  isDelete={msg.isDelete}
                />
            )}
          </div>
        </div>

        <div className="chat_input_container">
          <ContentEditable 
            ref={input}
            className='chat_input'
            html={txt}
            onChange={e => onChange(e)} 
            onKeyDown={e => {
              if(e.key === 'Enter'){
                e.preventDefault();
                console.log(props.messages)
                sending(chatmessages);
              }
            }}
            contentEditable={true}
          />
          <div className="chat_send_button"
            onClick={ () => {
              sending(chatmessages);
            }}
          >
              <img src={`${URL.SERVER}/images/send.png`} />
          </div>
        </div>
      </div>
  );
}

export default ChatApp;