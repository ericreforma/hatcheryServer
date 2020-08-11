import React,{Component} from 'react';
import {Link} from 'react-router-dom';

export default class Authenticate extends Component {
    constructor(props){
        super(props);
        this.state={
            redirectToReferrer: false,
        }
    }
    authenticate = () => {
        this.isAuthenticated = true
        setTimeout(cb, 100)
    }

    signout = (cb) = () => {
        this.isAuthenticated = false
        setTimeout(cb, 100)
    }
    
    render () {
        return(
            <Authenticate authenticate={this.authenticate} />
        );
    }
}

