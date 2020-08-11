import axios from 'axios';
import { API, TOKENIZED_API, FORM_API } from '../config/api';
import COOKIE from '../config/cookies';

let httpRequest;

const HttpRequest = {
  get: (url, args = {}) => {
    // Object.assign(args, { uid: COOKIE.uid() });
    httpRequest = axios.create(TOKENIZED_API());
    
    return httpRequest.get(url, { params: args })
  },

  post: (url, args = {}) => {
    // Object.assign(args, { uid: COOKIE.uid() });
    httpRequest = axios.create(TOKENIZED_API());

    return httpRequest.post(url, args)
  }
};

const HttpForm = {
  post: (url, formData, args = {}) => {
    // formData.append('uid',COOKIE.uid());
    
    httpRequest = axios.create(FORM_API());
    return httpRequest.post(url, formData, args);
  }
};

const RawHttpRequest = {
  get: (url) => {
    httpRequest = axios.create(API);
    return httpRequest.get(url);
  },
  post: (url, args = {}) => {
    httpRequest = axios.create(API);
    return httpRequest.post(url, args);
  }
};

export { HttpRequest, RawHttpRequest, HttpForm }