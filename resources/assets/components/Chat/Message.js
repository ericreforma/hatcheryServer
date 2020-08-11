import React from 'react'
import moment from 'moment-timezone';
import URL from '../../config/url';

export default function Message({ message, status, side, theTime, onDelete, isDelete }) {
  const isLeftSide = side === 'left';

  return (
    <div className='chat_message_container'>
      <div className={`message_bubble ${isLeftSide ? 'receiver_bubble' : 'sender_bubble'} 
        ${status && status} ${isDelete === 1 ? 'deleted' : ''}`}>

          { isDelete === 1 ? 'Message removed' : message }
        
          { !isLeftSide ? 
            <div className='chat_delete' onClick={ () => { onDelete() }}>
              <img src={`${URL.SERVER}/images/delete.png`} />
            </div>
          : <></>
          }
      </div>

      { status && status === 'sending' ? 
        <div className={`sending_message `}>
          <img src={`${URL.SERVER}/images/rolling.gif`}/> <span>sending...</span>
        </div>
      :
        <div className={`message_time ${isLeftSide ? 'left_time' : 'right_time'}`}>
          {moment(theTime).format('hh:mm a')}
        </div>
      }
      
    </div>
  )
}