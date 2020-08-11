import {
  Buttons,
  Alerts,
  Grid,
  Typography,
  Cards,
  Tabs,
  Tables,
  Breadcrumbs,
  Forms,
  Loaders,
  Avatars,
  Invoice,
  Analytics,
  CmsPage,
  Widgets,
  BlankPage,
  SubNav,
  Feed,
  Modals,
  ProgressBars,
  PaginationPage,
  ErrorPage
} from './samples';

import Dashboard from '../pages/Dashboard';
import { SocialMediaList, SocialMediaCreate, SocialMediaDetails } from '../pages/socialmedia';
import { EventList, EventCreate, EventDetails } from '../pages/event';
import Chat from '../pages/chat';
import TestUpload from '../pages/tests/TestUpload';
import testMail from '../pages/tests/mail';

const pageList = [
  {
    name: 'Dashboard',
    path: '/dashboard',
    component: Dashboard
  },
 
  {
    name: 'Social Media Campaign',
    path:'/campaign/socialmedia/list',
    component: SocialMediaList
  },
  {
    name: 'Social Media Campaign',
    path:'/campaign/socialmedia/create',
    component: SocialMediaCreate
  },
  {
    name: 'Social Media Campaign',
    path:'/campaign/socialmedia/details/:id',
    component: SocialMediaDetails
  },
  {
    name: 'Event',
    path:'/campaign/event/list',
    component: EventList
  },
  {
    name: 'Chat',
    path:'/chat',
    component: Chat
  },
  {
    name: 'Details',
    path:'/campaign/event/details/:id',
    component: EventDetails
  },
  {
    name: 'Event',
    path:'/campaign/event/create',
    component: EventCreate
  },
  {
    name: 'Buttons',
    path: '/elements/buttons',
    component: Buttons
  },
  {
    name: 'Alerts',
    path: '/elements/alerts',
    component: Alerts
  },
  {
    name: 'Grid',
    path: '/elements/grid',
    component: Grid
  },
  {
    name: 'Typography',
    path: '/elements/typography',
    component: Typography
  },
  {
    name: 'Cards',
    path: '/elements/cards',
    component: Cards
  },
  {
    name: 'Tabs',
    path: '/elements/tabs',
    component: Tabs
  },
  {
    name: 'Tables',
    path: '/elements/tables',
    component: Tables
  },
  {
    name: 'Progress Bars',
    path: '/elements/progressbars',
    component: ProgressBars
  },
  {
    name: 'Pagination',
    path: '/elements/pagination',
    component: PaginationPage
  },
  {
    name: 'Modals',
    path: '/elements/modals',
    component: Modals
  },
  {
    name: 'Breadcrumbs',
    path: '/elements/breadcrumbs',
    component: Breadcrumbs
  },
  {
    name: 'Forms',
    path: '/elements/forms',
    component: Forms
  },
  {
    name: 'Loaders',
    path: '/elements/loaders',
    component: Loaders
  },
  {
    name: 'Avatars',
    path: '/elements/avatars',
    component: Avatars
  },
  {
    name: 'Blank',
    path: '/pages/blank',
    component: BlankPage
  },
  {
    name: 'Sub Navigation',
    path: '/pages/subnav',
    component: SubNav
  },
  {
    name: '404',
    path: '/pages/404',
    component: ErrorPage
  },
  {
    name: 'Analytics',
    path: '/apps/analytics',
    component: Analytics
  },
  {
    name: 'Activity Feed',
    path: '/apps/feed',
    component: Feed
  },
  {
    name: 'Invoice',
    path: '/apps/invoice',
    component: Invoice
  },
  {
    name: 'CMS',
    path: '/apps/cms',
    component: CmsPage
  },
  {
    name: 'Widgets',
    path: '/widgets',
    component: Widgets
  },
  {
    name: 'TestUpload',
    path: '/test/imageupload',
    component: TestUpload
  },
  {
    name: 'TestMail',
    path: '/test/mail',
    component: testMail
  }
];

export default pageList;
