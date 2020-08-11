import image from '../images';

const SOCIALMEDIA = {
    facebook: {
        id: 0,
        name: 'facebook',
        prettyname: 'Facebook',
        shortname: 'FB',
        icon: image.facebook_colored,
        icon_small: require('../images/facebook_icon.png'),
    },
    instagram: {
        id: 1,
        name: 'instagram',
        prettyname: 'Instagram',
        shortname: 'IG',
        icon: image.instagram_colored,
        icon_small: require('../images/instagram_icon.png'),
    },
    youtube: {
        id: 2,
        name: 'youtube',
        prettyname: 'YouTube',
        shortname: 'YouTube',
        icon: image.youtube_colored,
        icon_small: require('../images/youtube_icon.png'),
    },
    twitter: {
        id: 3,
        name: 'twitter',
        prettyname: 'Twitter',
        shortname: 'Twitter',
        icon: image.twitter_colored,
        icon_small: require('../images/twitter_icon.png'),
    },
    google: {
        id: 4,
        name: 'google',
        prettyname: 'Google',
        shortname: 'G+',
        icon: image.google_colored,
        icon_small: require('../images/youtube_icon.png'),
    }
};
  
const GENDER = [
    'Male',
    'Female',
    'Any',
];

const ENGAGEMENT = [
    'Like',
    'Comment',
    'Share',
    'View',
];

const CAMPAIGN_TYPE = [
    'Online',
    'Event',
    'Survey'
];

const POST_STATUS = [
    'Pending',
    'Declined',
    'Approved',
    'Running',
    'Completed'
]

const STATUS = {
    CODE: {
        TYPE: {
            CAMPAIGN: 1,
            USER: 2,
            JOB_APPLICATION: 3
        },
        SOURCE: {
            CAMPAIGN: {
                SOCIALMEDIA: 1,
                EVENT: 2
            },
            USER: {
                CLIENT: 1,
                APP: 2
            },
            JOB_APPLICATION: {
                USER: 1
            }
    
        }
    }
    
}

const CAMPAIGN_STATUS = [
    'Posted',
    'Running',
    'Inactive',
]

export {
    SOCIALMEDIA,
    GENDER,
    ENGAGEMENT,
    CAMPAIGN_TYPE,
    POST_STATUS,
    CAMPAIGN_STATUS,
    STATUS
};

  