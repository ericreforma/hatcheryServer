import React from 'react';
import firebase from 'firebase/app';
import 'firebase/auth'
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom';
import Dashboard from '../assets/layout/Dashboard';
import { Login, SignUp } from '../assets/pages/auth';
import PrivacyPolicy from '../assets/pages/PrivacyPolicy';
import { ProtectedRoute, PublicRoute } from '../assets/route/index';
import URL from '../assets/config/url';
import Cookie  from '../assets/config/cookies';

const config = {
    apiKey: "AIzaSyCEW0L-HwB0akeP2JcwETCijsFp_u9Yh5A",
    authDomain: "influencerapp-872a0.firebaseapp.com",
    databaseURL: "https://influencerapp-872a0.firebaseio.com",
    projectId: "influencerapp-872a0",
    storageBucket: "influencerapp-872a0.appspot.com",
    messagingSenderId: "553833031460",
}

export default function App() {
	// firebase.initializeApp(config);
	
	// firebase.auth().onAuthStateChanged( user => {
	// 	if(!user) {
	// 		Cookie.remove();
	// 	}
	// })
	
	return (
		<BrowserRouter> 
			<Switch>
				<PublicRoute path={`/login`} component={Login} />
				<PublicRoute path={`/signup`} component={SignUp} />
				<PublicRoute path={`/privacy-policy`} component={PrivacyPolicy} />
				<ProtectedRoute path={'/'} component={Dashboard} />
			</Switch>
		</BrowserRouter>
	);
}