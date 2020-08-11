import React from 'react';
import { HttpForm } from '../../functions/HttpService';
import { Input } from 'reactstrap';

import URL from '../../config/url';

export default class TestUpload extends React.Component{
    constructor(props) {
        super(props);
        this.state = {
            image: null
        }
    }
    submit = () => {
        const formData = new FormData();

        formData.append("image", this.state.image);

        console.log(formData)
        console.log(this.state.image)
        HttpForm.post(URL.TEST.IMAGEUPLOAD, formData)
        .then( (response) => {
            console.log('DONe')
        })
        .catch( (e)=> {

            console.log('error');
            console.log(e.response);
            console.log(e.message);
            console.log(e.request.response);

        })
    }

    render = () =>
        <div>
            <h1>Tests</h1>

                <Input 
                    type='file'
                    name='image'
                    id='image'
                    accept='image/*'
                    multiple
                    onChange={ e => { 
                        this.setState({image: e.target.files[0]})
                    }}
                 />

                <button onClick={() => {
                    this.submit();
                }}> submit </button>
        </div>
}