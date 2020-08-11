import React, { Component } from 'react';
import moment from 'moment';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter, Card, CardBody } from 'reactstrap';
import { HttpRequest } from '../../functions/HttpService';
import URL from '../../config/url';
import ChatApp from '../../components/Chat';
import socket from '../../socket';
import Rating from '../../elements/Rating';

export default class Chat extends Component{
    constructor(props) {
        super(props);

        this.state = {
            currentTab: 'Social Media',
            tabList: ['Social Media', 'Events'],
            currentCampaignList: [],
            campaignList: [],
            sessionList: [],
            userList: [],
            width: 0,
            height: 0,
            currentSession: null,
            selectedCampaign: null,
            selectedUser: null,
            messages: [],
            sendingMessageQueue: [],
            previousSession_id: null,

            deleteModalvisible: false,
            chatIDtoDelete: null
        }

        this.updateWindowDimensions = this.updateWindowDimensions.bind(this);
    }

    compare = (a, b) => {
        if (a.id < b.id) {
            return 1;
        }
        if (a.id > b.id) {
            return -1;
        }

        return 0;
    }

    sendingMessageQueue = (text) => {
        const messages = this.state.messages;

        const max = Math.max.apply(Math, messages.map(function(o) { return o.id; }));
        
        const sending_id = messages.length !== 0 ? parseInt(max) + 1 : 0;
        
        const message = {
            id: sending_id,
            sending_id: sending_id,
            session_id: this.state.currentSession ? this.state.currentSession.id : null,
            user_id: this.state.selectedUser.profile.id,
            client_id: this.state.selectedCampaign.client_id,
            campaign_type: this.state.selectedCampaign.type,
            campaign_id: this.state.selectedCampaign.id,
            type: 0,
            message: text,
            sender: 1,
            status: 'sending'
        }

        messages.push(message);
        messages.sort(this.compare);
        this.setState({ messages });

        HttpRequest.post(URL.CHAT.SEND, message)
        .then(response => {
            console.log(response.data);
            this.sent(response.data.id, response.data.sending_id);
            if(this.state.currentSession === null) {
                this.setState({ currentSession: response.data.session })
            }
        }).catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        });
    }

    sent = (id, sending_id) => {
        const messages = this.state.messages;
        const msg = messages.find(x => x.sending_id === sending_id);
        const index = messages.findIndex(x => x.sending_id === sending_id);
        msg.status = 'sent';
        msg.id = id;
        messages[index] = msg;
        messages.sort(this.compare);
        this.setState({ messages });
    }

    
    getChatMessages = () => {
        HttpRequest.get(URL.CHAT.MESSAGES, { 
            session_id: this.state.currentSession.id,
        })
        .then(response => {
            
            socket.leaveChat(this.state.previousSession_id);

            const messages = response.data;
            messages.sort(this.compare);
            this.setState({
                messages, 
                previousSession_id: this.state.currentSession.id 
            });

            socket.chat(this.state.currentSession.id, e => {
                if(e.type == 'forDelete') {
                    const messages = this.state.messages;
                    messages.forEach(function(m, index){
                        if(this[index].id === e.chat.id) {
                            this[index].isDelete = 1;
                        }
                    }, messages);
                    this.setState({ messages });
                } else {
                    if(e.chat.sender == 0) {
                        messages.push(e.chat);
                        messages.sort(this.compare);
                        this.setState({ messages });
                    }
                }
                
            });
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        })
    }

    getChatSession = () => {
        HttpRequest.get(URL.CHAT.SESSION.GET, { 
            campaign_id: this.state.selectedCampaign.id,
            campaign_type: this.state.selectedCampaign.type,
            user_id: this.state.selectedUser.profile.id
        })
        .then(response => {
            
            this.setState({ currentSession: response.data === '' ? null : response.data }, 
            () => {
                if(this.state.currentSession !== null) {
                    this.getChatMessages();
                }
            })
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        })
    }

    getCampaigns = () => {

        HttpRequest.get(URL.CAMPAIGN.LIST)
        .then(response => {
            console.log(response.data)
            this.setState({ 
                campaignList: response.data,
                currentCampaignList: response.data.socialmedia
            });
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        });

    }

    componentDidMount() {
        this.getCampaigns();
        this.updateWindowDimensions();
        window.addEventListener('resize', this.updateWindowDimensions);
    }
    
    componentWillUnmount() {
        window.removeEventListener('resize', this.updateWindowDimensions);
    }
    
    updateWindowDimensions() {
        this.setState({ width: window.innerWidth, height: window.innerHeight });
    }

    campaignList = () => 
        <div className='chatlist_container'>
            <div className='custom_tab'>
            <ul className='tab'>
                    { this.state.tabList.map((tab, index) => 
                        <li className={`custom_list_tab ${this.state.currentTab == tab && 'active'}`} 
                            key={`chatTabList${index}`} 
                            onClick={e => 
                                this.setState({ 
                                    currentTab: tab, 
                                    currentCampaignList: 
                                        tab === 'Social Media' ?
                                        this.state.campaignList.socialmedia :
                                        this.state.campaignList.events
                                })
                            }
                        >
                            { tab }
                        </li>
                    )}
                </ul>
            
                <div className='custom_list'>
                    <div className='chat_list campaign_list'
                        style={{ height: this.state.height - 120 }}
                    >
                        { this.state.currentCampaignList && 
                        this.state.currentCampaignList.map((campaign, index) => 
                            <div className={`chat_user_container
                                ${this.state.selectedCampaign && campaign.id == this.state.selectedCampaign.id ? 
                                campaign.type == this.state.selectedCampaign.type ? 'chat_user_selected' : '' : ''}`}
                                key={index}>
                                    
                                <div className={'chat_user'}
                                    onClick={ () => {

                                        this.setState({ 
                                            messages: [],
                                            currentSession: null,
                                            selectedCampaign: campaign,
                                            userList: campaign.users,
                                            selectedUser: campaign.users[0] || null
                                        }, () => {
                                            if(this.state.selectedUser !== null){
                                                this.getChatSession();
                                            }
                                        });
                                    }}
                                >
                                    <div className='campaign_body'>
                                        <div className='chat_user_photo' 
                                            style={{backgroundImage: 
                                                `url(${URL.SERVER_STORAGE}/${campaign.media[0].url})`}}>
                                        </div>
                                        <div className='chat_details'>
                                            <h4>{ campaign.name }</h4>
                                            <h5 className='time'>{ moment(campaign.created_at).format('MMM D, Y') }</h5>
                                            <div className='user_count'>
                                                <img src='./images/social.png'/><span>{ campaign.users.length }</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                </div>
                                
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
   
    userlistContainer = () =>
        <div className='userlist_container'>
            <div className='chat_list user_list'>
                { this.state.selectedCampaign && 
                
                    <div className='current_campaign'
                        style={{backgroundImage: this.state.selectedCampaign ?
                            `url(${URL.SERVER_STORAGE}/${this.state.selectedCampaign.media[0].url})` :
                            ``}}
                    >
                        <h4>{ this.state.selectedCampaign.name }</h4>
                    </div>
                }

                { this.state.userList.length === 0 ?
                    <p>No active users</p>
                : this.state.userList.map((user, index) => 
                    <div className={`chat_user_container
                        ${this.state.selectedUser && 
                        user.id === this.state.selectedUser.id ? 'chat_user_selected' : ''}`}
                        key={`chatUser_${index}`}
                        onClick={ () => {
                            this.setState({ selectedUser: user }, () => {
                                console.log('getting chat session')
                                console.log('selected user', this.state.selectedUser)
                                this.getChatSession();
                            })
                        }}
                    >
                        <div className='chat_user'>
                            <div>
                                <div className='chat_user_photo' 
                                    style={{backgroundImage: user.profile.media ?
                                        `url(${URL.SERVER_STORAGE}/${user.profile.media.url})` :
                                        `url(${URL.SERVER}/images/default_avatar.png)`}}>
                                </div>
                                <div className='chat_details'>
                                    <h4>{ user.profile.name }</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </div>

    deleteMessage = chat_id => {
        this.setState({ 
            deleteModalvisible: true,
            chatIDtoDelete: chat_id
        });
    }

    confirmDelete = () => {
        HttpRequest.get(URL.CHAT.DELETE, { chat_id: this.state.chatIDtoDelete })
        .then(response => {
            this.setState({ 
                deleteModalvisible: false,
                chatIDtoDelete: null
            });
            this.getChatMessages();
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        })
    }

    messageContainer = () =>
        <div className='message_container'>
            { this.userDetails() }
            { 
                <ChatApp 
                    messages={this.state.messages}
                    height={window.innerHeight}
                    sendingMessageQueue={this.sendingMessageQueue}
                    sent={this.sent}
                    onDelete={this.deleteMessage}
            /> }
        </div>

    userDetails = () =>
            <div className='profile_container'>
                 { this.state.selectedUser && 
                    <>
                        <div className='profile_photo'
                            style={{backgroundImage: this.state.selectedUser.profile.media ?
                                `url(${URL.SERVER_STORAGE}/${this.state.selectedUser.profile.media.url})` :
                                `url(${URL.SERVER}/images/default_avatar.png)`}}>
                        </div>
                        <h1 className='profile_name'>
                            { this.state.selectedUser.profile.name }
                        </h1>
                        <Rating rating={this.state.selectedUser.profile.rating} averageVisible={false} countVisible={false} />

                        <div className='smaContainer'>
                           
                        </div>
                    </>
                  }
            </div>

    deleteModal = () =>
        <Modal isOpen={this.state.deleteModalvisible} toggle={this.toggleModal}>
            <ModalHeader toggle={this.toggleModal}>Confirm Delete</ModalHeader>
            <ModalBody>
                  Are you sure  do you want to delete this message?
            </ModalBody>
            <ModalFooter>
                <Button color="secondary" onClick={this.confirmDelete}>Yes</Button>{' '}
                <Button color="primary" onClick={this.toggleModal}>No</Button>
            </ModalFooter>
        </Modal>

    toggleModal = () => {
        this.setState({
            deleteModalvisible: !this.state.deleteModalvisible
        });
    }
    render = () =>
        <div 
            className='chat'
            style={{ height: this.state.height - 120 }}
        >   
            { this.deleteModal() }
            <div className='chat_container'>
                { this.campaignList() }
                { this.userlistContainer() }

                { this.state.selectedUser && this.messageContainer() }
               
            </div>
        </div >

}