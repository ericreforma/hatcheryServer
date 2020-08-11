import { RawHttpRequest, HttpRequest } from '../functions/HttpService';
import firebase from 'firebase/app';
import 'firebase/auth'
import URL from '../config/url';
import COOKIE from '../config/cookies';

const AuthFunction = {

    login: (email, password, success, failed) => {
        RawHttpRequest.post(URL.LOGIN, { email, password })
        .then(response => {
            console.log(response.data)
            

            COOKIE.set(response.data.token, () => {
                success();
            });
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
            failed();
        });
    },

    logout: callback =>  {
        COOKIE.remove();
        callback();
    },
    
    firebase_login: (thisuser, token, successCallBack) => {
        COOKIE.set(token, () => {
            const user = JSON.stringify(thisuser);
            setTimeout(() => {
                HttpRequest.post(URL.FIREBASE.LOGIN, { user })
                .then(response => {
                    
                    console.log(response.data);
                    successCallBack();
    
                })
                .catch(e => {
                    console.log(e);
                    console.log(e.response.data);
                    console.log(e.response.status);
                    console.log(e.response.headers);
                });
            }, 1000);
        });
    },
    
    signup: (name, business_name, email, contact_number, password, success) => {
        RawHttpRequest.post(URL.SIGNUP, { 
            name, business_name, email, password, contact_number 
        })
        .then(response => {
            COOKIE.set(response.data.token, () => {
                success();
            });
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        });
    },
   
    firebase: {
        login: (email, password, success, failed) =>
            firebase.auth().signInWithEmailAndPassword(email, password)
            .then((result) => {
                result.user.getIdToken()
                .then(token => {
                    COOKIE.set(result.user.uid, token, () => {
                        success();
                    });
                })
            })
            .catch(function(error) { 
                console.log(error.code);
                console.log(error.message);
                failed();
            }),
        signup: (client, successCallBack, failedCallBack) => {
            firebase.auth().createUserWithEmailAndPassword(client.email, client.password)
            .then((result) => {

                result.user.getIdToken()
                .then(token => {
                    COOKIE.set(result.user.uid, token, () => {
                        Object.assign(client, { uid: result.user.uid });
                        const thisClient = JSON.stringify(client);

                        HttpRequest.post(URL.FIREBASE.SIGNUP, { thisClient })
                        .then(response => {
                            successCallBack();
                        })
                        .catch(e => {
                            console.log(e);
                            console.log(e.response.data);
                            console.log(e.response.status);
                            console.log(e.response.headers);
                            failedCallBack();
                        })
                    });
                });
            })
            .catch(error => {
                console.log(error)
                failedCallBack(error);
            })
        },
        google: (successCallBack) => {
            let provider = new firebase.auth.GoogleAuthProvider();
            provider.addScope('profile');
            provider.addScope('email');

            firebase.auth().signInWithPopup(provider).then(function(result) {
                result.user.getIdToken()
                .then(token => {
                    successCallBack(result.user, token);
                });
            }).catch(function(error) {
                console.log(error.code);
                console.log(error.message);
                console.log(error.email);
                console.log(error.credential);
            });
        },
        facebook: (successCallBack) => {
            var provider = new firebase.auth.FacebookAuthProvider();

            firebase.auth().signInWithPopup(provider).then(function(result) {
                result.user.getIdToken().then(token => {
                    successCallBack(result.user, token);
                });

              }).catch(function(error) {
                console.log(error.code);
                console.log(error.message);
                console.log(error.email);
                console.log(error.credential);
                
              });
        },
        
        logout: (callback) =>{
            COOKIE.remove();
            firebase.auth().signOut();
            callback();

        }
    }
}

export default AuthFunction;

