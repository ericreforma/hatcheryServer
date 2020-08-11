import { HttpRequest } from './HttpService';
import URL from '../config/url';

const InfluencerFunction = {
    profile: id => HttpRequest.get(URL.INFLUENCER.PROFILE, { id }),
}

export default InfluencerFunction;
