import React, { Component } from 'react';
import firebase from 'firebase/app';
import 'firebase/auth'

import { Switch, Route, Redirect } from 'react-router-dom';
import { Button, Badge, NavItem, UncontrolledDropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';
import { Header, SidebarNav, Footer, PageContent, Avatar, PageAlert, Page } from '../components';
import Logo from '../../img/vibe-logo.svg';
import nav from '../nav';
import FA from 'react-fontawesome';
import { PageList as routes, ProtectedRoute } from '../route/index';
import ContextProviders from '../components/utilities/ContextProviders';
import { HttpRequest } from '../functions/HttpService';
import Authfunction  from '../functions/AuthFunction';
import URL from '../config/url';
import socket from '../socket';
import axios from 'axios';


const MOBILE_SIZE = 992;

export default class Dashboard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      profile: null,
      isLoggedIn:false,
      clientEmail:'',
      sidebarCollapsed: false,
      isMobile: window.innerWidth <= MOBILE_SIZE,
      showChat1: true,
      messageUserList: [],
      chatList: [],

    };
  }

  getClientDetails = () => {
    console.log(URL.PROFILE);
    console.log(HttpRequest)

    // axios.get('https://www.thehatchery.app/api/client/test')
    // .then(function (response) {
    //   // handle success
    //   console.log(response);
    // })
    // .catch(function (error) {
    //   // handle error
    //   console.log(error);
    // })
    // .then(function () {
    //   // always executed
    // });

    HttpRequest.get(URL.PROFILE)
    .then(response => {
      console.log(response);
      // this.setState({ profile: response.data }, () => {
      //   socket.init(this.state.profile.id);
      // });
    })
    .catch(e => {
      console.log(e);
      console.log(e.response);
      console.log(e.response.data);
      console.log(e.response.status);
      console.log(e.response.headers);
    })
  }
  
  getMessageUserList = () => {
    // HttpRequest.get(URL.USERS)
    // .then(response => {
    //   this.setState({ messageUserList: response.data });
    // });
  }

  handleResize = () => {
    if (window.innerWidth <= MOBILE_SIZE) {
      this.setState({ sidebarCollapsed: false, isMobile: true });
    } else {
      this.setState({ isMobile: false });
    }
  };

  componentDidUpdate(prev) {
    if (this.state.isMobile && prev.location.pathname !== this.props.location.pathname) {
      this.toggleSideCollapse();
    }
  }

  componentDidMount() {
    this.getClientDetails();
    this.getMessageUserList();

    window.addEventListener('resize', this.handleResize);
  }

  componentWillUnmount() {
    window.removeEventListener('resize', this.handleResize);
  }

  toggleSideCollapse = () => {
    this.setState(prevState => ({ sidebarCollapsed: !prevState.sidebarCollapsed }));
  };

  closeChat = () => {
    this.setState({ showChat1: false });
  };

  HeaderNav = () => 
    <React.Fragment>
      <UncontrolledDropdown nav inNavbar className='chat_button'>
        <DropdownToggle nav>
        <FA name="comment" />
        </DropdownToggle>


        <DropdownMenu right>
            
            { this.state.messageUserList &&
                this.state.messageUserList.map((user, index) => 
                    <DropdownItem onClick={e => {
                      const chatList = this.state.chatList;
                      chatList.push(user);

                      this.setState({ chatList });
                    }}
                    key={index}>
                        <img src={`${URL.SERVER_STORAGE}/${user.media.url}`} />
                        <p>{ user.name }</p>
                    </DropdownItem>
                )
            }
            
            <DropdownItem divider />
            <DropdownItem>
            Message <Badge color="primary">{this.state.messageUserList.length}</Badge>
            </DropdownItem>
        </DropdownMenu>



      </UncontrolledDropdown>
      <UncontrolledDropdown nav inNavbar>
        <DropdownToggle nav>
          {
            <img 
              className='dashboard_profile_photo'
              src={ this.state.profile && this.state.profile.media_id != 0 ? 
                `${URL.SERVER_STORAGE}/${this.state.profile.media.url}`:
                `${URL.SERVER}/images/default_avatar.png`
              }
            />
             
          }
          
        </DropdownToggle>
        <DropdownMenu right>
          
          <DropdownItem onClick={() => {
            Authfunction.logout(() => {
              this.props.history.push('/');
            });
          }}>Logout</DropdownItem>
        </DropdownMenu>
      </UncontrolledDropdown>
    </React.Fragment>


  render() {
    const { sidebarCollapsed } = this.state;
    const sidebarCollapsedClass = sidebarCollapsed ? 'side-menu-collapsed' : '';
    return (
      <ContextProviders>
        <div className={`app ${sidebarCollapsedClass}`}>
          <PageAlert />

          <div className="app-body">
            <SidebarNav
              nav={nav}
              logo={Logo}
              logoText="Influencer"
              isSidebarCollapsed={sidebarCollapsed}
              toggleSidebar={this.toggleSideCollapse}
              {...this.props}
            />

            <Page>
              <Header
                toggleSidebar={this.toggleSideCollapse}
                isSidebarCollapsed={sidebarCollapsed}
                routes={routes}
                {...this.props}
              >
            { this.HeaderNav() }
              </Header>

              <PageContent>
                <Switch>
                  {routes.map((page, key) => (
                    <ProtectedRoute path={page.path} component={page.component} key={key} />
                  ))}
                  <Redirect from="/" to="/dashboard" />
                </Switch>

              </PageContent>
            </Page>
          </div>
{/*           
          { this.state.chatList.map((user, index) => 
            <Chat receiver={user} index={index} key={index}/>
          )} */}
            
        </div>
      </ContextProviders>
    );
  }
}

