import { HttpRequest, HttpForm } from './HttpService';
import URL from '../config/url';

const CampaignFunction = {
    socialmedia: {
        list: page => HttpRequest.get(URL.SOCIALMEDIA.LIST, { page }),
        details: page => HttpRequest.get(`${URL.SOCIALMEDIA.DETAILS}/${page}`),
        user: {
            list: sm_campaign_id => HttpRequest.get(URL.SOCIALMEDIA.DETAILS, { sm_campaign_id }),
            posts: (user_id, social_media_id) => HttpRequest.get(URL.SOCIALMEDIA.USER.POSTS, { user_id, social_media_id }),
        },
        post: {
            changeStatus: (post_id, status) => HttpRequest.post(URL.SOCIALMEDIA.POST.CHANGESTATUS, { post_id, status }),
        }
        
        
    },
    event: {
        list: page => HttpRequest.get(URL.EVENT.LIST, { page }),
        details: page => HttpRequest.get(`${URL.EVENT.DETAILS}/${page}`),
        applicant: {
            profile: (event_applicant_id, eventjob_id, user_id) => HttpRequest.get(`${URL.EVENT.APPLICANT.PROFILE}`, { event_applicant_id, eventjob_id, user_id }),
            setStatus: (event_applicant_id, status) => HttpRequest.get(`${URL.EVENT.APPLICANT.SETSTATUS}`, { event_applicant_id, status }),
        },
    },
    categories: () => HttpRequest.get(URL.CATEGORIES),
    skills: () => HttpRequest.get(URL.SKILLS),
    jobs: () => HttpRequest.get(URL.JOBS)
}


export default CampaignFunction;