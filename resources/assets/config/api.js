import URL from './url';
import COOKIE from './cookies';

const baseURL = URL.SERVER;
const timeout = 30000; //30 seconds
const headers = {
  'Accept': 'application/json'
};

const API = {
  baseURL,
  timeout,
  headers
};

const TOKENIZED_API = () => {
  const token = COOKIE.token();
  const api = API;

  api.headers.Authorization = `Bearer ${token}`;

  return api;
};

const FORM_API = () => {
  const api = TOKENIZED_API();

  api.headers['Content-Type'] = 'multipart/form-data';

  return api;
}

export { API, TOKENIZED_API, FORM_API };
