import React from 'react';
import { Redirect, Route } from 'react-router-dom';
import COOKIE from '../config/cookies';

const ProtectedRoute = ({ component: Component, ...rest }) => (
    <Route {...rest} 
        render={(props) => (
            COOKIE.hasToken() ?
                <Component {...props} />
            :
                <Redirect to={{ pathname: '/login' }} />
        )}
	/>
);

export default ProtectedRoute;
