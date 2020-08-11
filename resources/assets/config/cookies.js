import Cookies from 'universal-cookie';

const MAX_AGE = 12*60*60; // 12 hours
const PATH = '/';

const OPTIONS = {
    path: PATH,
    maxAge: MAX_AGE,
    sameSite: true
}

const COOKIE = {
    set: (token, callback) => {
        const cookie = new Cookies;
        cookie.set('tr', token, OPTIONS);

        callback();
    },
    token: () => {
        const cookie = new Cookies;
        return cookie.get('tr');
    },
    uid: () => {
        const cookie = new Cookies;
        return cookie.get('tk');
    },
    hasToken: () => {
        const cookie = new Cookies;
        return cookie.get('tr') !== undefined;
    },
    remove: () => {
        const cookie = new Cookies;
        cookie.remove('tr',{ path: '/' });
    }
}

export default COOKIE;