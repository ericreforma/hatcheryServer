import React, { useState, useEffect } from 'react';
import moment from 'moment';
import { Input } from 'reactstrap';

const TimeSelect = props => {
    let selectedTime = moment(props.selectedTime).format('YYYY-MM-DDTHH:mm:00');
    let [newTime, setNewTime] = useState(props.selectedTime);

    const [hour, setHour] = useState(moment(selectedTime).format('h'));
    const [minute, setMinute] = useState(moment(selectedTime).format('mm'));
    const [ampm, setAmpm] = useState(moment(selectedTime).format('a'));

    let hour_options = [];
    let minute_options = [];

    useEffect(() => {
        setHour(moment(props.selectedTime).format('h'));
        setMinute(moment(props.selectedTime).format('mm'));
        setAmpm(moment(props.selectedTime).format('a'));
    }, [props.selectedTime]);

    useEffect(() => {   
        props.onChange(newTime);
    }, [newTime]);
    
    useEffect(() => {
        const newHour = ampm == 'pm' ? (parseInt(hour) == 12 ? hour : parseInt(hour) + 12) : 
                        parseInt(hour) == 12 ? '00' : parseInt(hour) < 10 ? `0${hour}` : hour;

        const newMinute = parseInt(minute) < 10 && parseInt(minute) != 0 ? `0${minute}` : minute;
        setNewTime(`${moment(selectedTime).format('YYYY-MM-DD')}T${newHour}:${newMinute}:00`);
    }, [hour, minute, ampm]);

    for(let x = 1; x < 13; x++){
        hour_options.push(<option key={x}>{x}</option>)
    }

    for(let x = 0; x < 60; x+= 15){ 
        minute_options.push(<option key={x}>{x < 9 ? `0${x}` : x}</option>)
    }

    return (
        <div className={`time_select_container ${props.className}`}>
            
            <Input type='select' name='hour_select' className='time_select hour_select'
                value={hour}
                onChange={e => { 
                    setHour(e.target.value);
                }}
            >
                { hour_options.map(hour => hour) }
            </Input>
            <span>:</span>
            <Input type='select' name='minute_select' className='time_select minute_select'
                value={minute}
                onChange={e => { 
                    setMinute(e.target.value);
                }}
            >
                { minute_options.map(minute => minute) }
            </Input>
            <Input type='select' name='a_select' className='time_select a_select'
                value={ampm}
                onChange={e => { 
                    setAmpm(e.target.value)
                 }}
            >
                <option>am</option>
                <option>pm</option>
            </Input>
        </div>
    );
}

export default TimeSelect;