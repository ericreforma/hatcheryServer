import React from 'react';
import { Row, Col, Button } from 'reactstrap';
import URL from '../../assets/config/url'

const PostMedia = props => {
    const displayPhotos = (media) => {
        switch(media.length) {
            case 1:
                return singlePhoto(media);
            case 2:
                return doublePhoto(media);
            case 3:
                return triplePhoto(media);
            case 4:
                return multiPhoto(media);
            default: 
                return multiPhoto(media);
           
        }
    }
    const displayMedia = (url, type) => 
        <>
            { type === 0 ? 
                <div className='photo' 
                    style={{backgroundImage: `url(${URL.SERVER_STORAGE}/${url})`}}>
                </div>
            :
                <video width="100%" height="auto" controls>
                    <source src={`${URL.SERVER_STORAGE}/${url}`} type="video/mp4" />
                </video>
            }
        </>

    const singlePhoto = media =>
        <div className='col-100'>
            { displayMedia(media[0].url, media[0].type) }

        </div>

    const doublePhoto = media =>
        <div className='col-100'>
            <div className='col-50'>
                { displayMedia(media[0].url, media[0].type) }
            </div>
            <div className='col-50'>
                { displayMedia(media[1].url, media[1].type) }
            </div>
        </div>

    const triplePhoto = media =>
        <>
            <div className='col-50'>
                { displayMedia(media[0].url, media[0].type) }
            </div>
            <div className='col-50'>
                <div className='row-50'>
                    { displayMedia(media[1].url, media[1].type) }
                </div>
                <div className='row-50'>
                    { displayMedia(media[2].url, media[2].type) }
                </div>
            </div>
        </>

    const multiPhoto = media =>
        <div className='col-100'>
            <div className='col-50'>
                <div className='row-50'>
                    { displayMedia(media[0].url, media[0].type) }
                </div>
                <div className='row-50'>
                    { displayMedia(media[1].url, media[1].type) }
                </div>
            </div>
            <div className='col-50'>
                <div className='row-50'>
                    { displayMedia(media[2].url, media[2].type) }
                </div>
                <div className='row-50'>
                    { displayMedia(media[3].url, media[3].type) }
                    { media.length > 4 ? 
                        <div className='moreMedia'>
                            
                            + {media.length - 4}
                        </div> : <></>
                    }
                </div>
            </div>
        </div>
        
    return (
        <div className='postMedia'>
            { displayPhotos(props.media) }
        </div>
    )
}

export default PostMedia;