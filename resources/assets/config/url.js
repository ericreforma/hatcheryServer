const bcdserver = 'https://www.thehatchery.app';
const hatchserver = 'https://www.thehatchery.app';
const localhost = 'http://localhost/influencer/public';

const SERVER = hatchserver;
const SERVER_STORAGE = `${SERVER}/storage`;
const BASE = '';

export default URL = {
    BASE,
    SERVER,
    SERVER_STORAGE,
    API: `${SERVER}/api`,
    LOGIN: `${SERVER}/api/client/login`,
    SIGNUP: `${SERVER}/api/client/signup`,
    PROFILE: `${SERVER}/api/client/profile`,
    
    FIREBASE: {
        LOGIN: `${SERVER}/api/client/firebase/login`,
        SIGNUP: `${SERVER}/api/client/firebase/signup`,
    },

    USERS: `${SERVER}/api/client/users`,

    CAMPAIGN: {
        LIST: `${SERVER}/api/client/campaign/list`,
        USER: {
            LIST: `${SERVER}/api/client/campaign/user/list`,
        }
    },

    SOCIALMEDIA: {
        PUBLISH: `${SERVER}/api/client/socialmedia/publish`,
        LIST: `${SERVER}/api/client/socialmedia/list`,
        DETAILS: `${SERVER}/api/client/socialmedia/details`,
        USER: {
            LIST:  `${SERVER}/api/client/socialmedia/user`,
            POSTS: `${SERVER}/api/client/socialmedia/user/posts`,
        },
        POST: {
            LIST: `${SERVER}/api/client/socialmedia/post/list`,
            CHANGESTATUS: `${SERVER}/api/client/socialmedia/post/changestatus`,
            ONLINEREMOVE: `${SERVER}/api/client/socialmedia/post/online/remove`,
        }
    },

    EVENT: {
        PUBLISH: `${SERVER}/api/client/event/publish`,
        LIST: `${SERVER}/api/client/event/list`,
        DETAILS: `${SERVER}/api/client/event/details`,
        APPLICANT: {
            LIST: `${SERVER}/api/client/event/applicant/list`,
            PROFILE: `${SERVER}/api/client/event/applicant/profile`,
            SETSTATUS: `${SERVER}/api/client/event/applicant/setStatus`,
        },
    },

    INFLUENCER: {
        PROFILE: `${SERVER}/api/client/influencer/profile`
    },

    CATEGORIES: `${SERVER}/api/client/categories`,
    SKILLS: `${SERVER}/api/client/skills`,
    JOBS: `${SERVER}/api/client/jobs`,

    CHAT: {
        SESSION: {
            GET: `${SERVER}/api/client/chat/session/`,
            CREATE: `${SERVER}/api/client/chat/session/create`,
            LIST: `${SERVER}/api/client/chat/session/list`,
        },
        MESSAGES: `${SERVER}/api/client/chat/messages`,
        SEND: `${SERVER}/api/client/chat/send`,
        DELETE: `${SERVER}/api/client/chat/delete`,
    },

    TEST: {
        IMAGEUPLOAD: `${SERVER}/api/client/test/imageUpload`,
    }
};
