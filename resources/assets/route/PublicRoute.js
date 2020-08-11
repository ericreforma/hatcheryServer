import React from 'react';
import { Redirect, Route } from 'react-router-dom';
import COOKIE from '../config/cookies';

const PublicRoute = ({ component: Component, ...rest }) => (
    <Route {...rest} 
        render={(props) => (
            COOKIE.hasToken() ?
                <Redirect to={{ pathname: '/dashboard' }} />
            :
                <Component {...props} />
        )}
	/>
);

export default PublicRoute;
