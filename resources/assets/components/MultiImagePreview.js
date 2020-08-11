import React, { useState, useEffect } from 'react';

const MultiImagePreview = props => {
    const [images, setImages] = useState(props.images);
    
    useEffect(() => {
        setImages(props.images);
    }, [props.images])

    return (
        images.map((img, index) => 
        <div key={index}>
            <div className='close_container'>
                <i className="fas fa-times-circle"></i>
            </div>

            <img src={window.webkitURL.createObjectURL(img)} />
        </div>
        )
    )
}

export default MultiImagePreview;