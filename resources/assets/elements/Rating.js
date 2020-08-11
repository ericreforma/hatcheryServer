import React, {useState, useEffect} from 'react';
import URL from '../../assets/config/url'

const Rating = props => {
    const star_full = `${URL.SERVER}/images/star_full.png`;
    const star_half = `${URL.SERVER}/images/star_half.png`;
    const star_empty = `${URL.SERVER}/images/star_empty.png`;

    const average = parseInt(props.rating.average);
    const decimal = (props.rating.average - average) * 10;
    const count = props.rating.count;
    const total = props.rating.total;

    return (
        <div className='rating' style={props.style && props.style}>
            { props.averageVisible && 
                <div className='average_container'>
                    {props.rating.average}
                </div>
            }
            
            <div className='icon_container'>
                {Array(5).fill(star_full).map((star, index) =>
                    <img key={index} src={
                        ((index + 1) <= average) ? star :
                        parseInt((index + 1) - props.rating.average) == 0 ? 
                            decimal >= 5 ? star_half : star_empty
                            : star_empty
                    }/>
                )}
            </div>

            { props.countVisible && 
                <div className='count_container'>
                    ({count})
                </div>
            }
            
        </div>
    );
}

export default Rating;