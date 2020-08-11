import React, { Component } from 'react';
import { Row, Col, Button } from 'reactstrap';
import { Carousel } from 'react-responsive-carousel';
import "react-responsive-carousel/lib/styles/carousel.min.css";
import Rating from '../../../elements/Rating';
import { CampaignFunction } from '../../../functions';
import { HttpRequest } from '../../../functions/HttpService';
import URL from '../../../config/url';
import { SOCIALMEDIA } from '../../../config/variables';
import moment from 'moment';


export default class Posts extends Component {
	constructor(props) {
		super(props);
		this.state = {
			socialMedia: this.props.socialMedia,

			user_pending: [],
			user_approved: [],
			user_active: [],
			user_rejected: [],

            postTabs: ['Pending','Approved', 'Active','Rejected'],
            profileTab:['Posts','Profile', 'Reviews'],

            activeUserPostTab: 0,
            activeProfileTab: 0,

            user_selected: null
        }
	}   

    componentDidMount() {
        this.refresh();
    }

    refresh = () => {
        HttpRequest.get(URL.SOCIALMEDIA.POST.LIST, { id: this.props.socialMedia.id })
        .then(response => {
            this.setState({ 
                user_pending: response.data.PENDING,
                user_approved: response.data.APPROVED,
                user_active: response.data.ACTIVE,
                user_rejected: response.data.REJECTED,
                user_selected: null
            });
        })
        .catch(e => {
            console.log(e);
        })
    }
    
    changeStatus = (post_id, post_status) => {
        let status = post_status;

        console.log(this.state.user_selected.fcm_token)
        console.log(status);

        HttpRequest.post(URL.SOCIALMEDIA.POST.CHANGESTATUS, { post_id, status, fcm_token: this.state.user_selected.fcm_token })
        .then(response => {
            this.refresh();
        })
        .catch( e => {
            this.refresh();
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        })
    }

    getUserPosts = (user_id, social_media_id, status) => {
        HttpRequest.get(URL.SOCIALMEDIA.USER.POSTS, { user_id, social_media_id, status })
        .then(response => {
            console.log(response.data)
            this.setState({ 
                user_selected: response.data,
            });
        })
        .catch(e => {
            console.log(e);
        })

    }

    setProfileTab = () => {
        switch(this.state.activeProfileTab){
            case 0:
                return this.posts()
            case 1:
                return this.profile_information()
        }
    }

    posts = () =>
        this.state.user_selected &&
        <div className='post_wrapper'>
            <Carousel 
                showThumbs={false}
                showStatus={false}
                showIndicators={false}
                useKeyboardArrows
                emulateTouch
                dynamicHeight
                className='carousel-slider'
            >
                { this.state.user_selected.posts.map((post, index) => 
                    <div className='post_container' key={index}>
                        <div className='post_media'>
                            { post.media.type == 0 ?
                                <div className='post_image' 
                                    style={{backgroundImage: 
                                        `url(${URL.SERVER}/storage/${post.media.url})`}}>
                                </div>
                                :
                                <video width="100%" height="auto" controls>
                                    <source src={`${URL.SERVER}/storage/${post.media.url}`} type="video/mp4" />
                                </video>
                            }
                        </div>
                        <div className='post_body'>
                            <h3>{ post.title} </h3>
                            <p>{ post.caption }</p>
                            <p>{ post.tags }</p>
                            <hr />
                            <div className='post_details'>
                                <Row>
                                    <Col md={3}>
                                        <p>Status</p>
                                    </Col>
                                    <Col md={9}>
                                        { post.status}
                                    </Col>
                                </Row>
                                
                                <Row>
                                    <Col md={3}>
                                        <p>Created</p>
                                    </Col>
                                    <Col md={9}>
                                        <p>{ moment(post.created_at).format('MMM. d, YYYY hh:mm a')}</p>
                                    </Col>
                                </Row>
                                <Row>
                                    <Col md={3}>
                                        <p>Platforms</p>
                                    </Col>
                                    <Col md={9}>
                                        { post.sma && post.sma.map((sma, index) =>
                                            <div className='post_sma' 
                                                key={index}
                                                style={{backgroundImage: 
                                                    `url(${Object.values(SOCIALMEDIA)[sma.sma_id].icon})`}}>
                                            </div> 
                                        )}
                                    </Col>
                                </Row>
                                <hr />
                                <Row>
                                    { post.status == 'PENDING' ?
                                    <>
                                        <Col md={4}>
                                            <Button color='secondary' block>Send Message</Button>
                                        </Col>
                                        
                                        <Col md={4}>
                                            <Button color='success' block onClick={e => {
                                                this.changeStatus(post.id, 'APPROVED');
                                            }}>APPROVE
                                            </Button>
                                        </Col>

                                        <Col md={4}>
                                            <Button color='danger' block onClick={e => {
                                                this.changeStatus(post.id, 'REJECTED');
                                            }}>REJECT
                                            </Button>
                                        </Col> 
                                    </>
                                    : post.status == 'APPROVED' ? 
                                        <>
                                            <Col md={4}>
                                                <Button color='secondary' block>Send Message</Button>
                                            </Col>
                                            
                                            <Col md={4}>
                                                <Button color='primary' block onClick={e => {
                                                    this.changeStatus(post.id, 'ACTIVE');
                                                }}>SET ACTIVE
                                                </Button>
                                            </Col>

                                            <Col md={4}>
                                                <Button color='danger' block onClick={e => {
                                                    this.changeStatus(post.id, 'REJECTED');
                                                }}>REJECT
                                                </Button>
                                            </Col> 
                                        </>
                                    : post.status == 'ACTIVE' ? 
                                        <>
                                            <Col md={4}>
                                                <Button color='secondary' block>Send Message</Button>
                                            </Col>
                                            
                                            <Col md={4}>
                                                <Button color='primary' block onClick={e => {
                                                    this.changeStatus(post.id, 'APPROVED');
                                                }}>SET INACTIVE
                                                </Button>
                                            </Col>

                                            <Col md={4}>
                                                <Button color='danger' block onClick={e => {
                                                    this.changeStatus(post.id, 'REJECTED');
                                                }}>REJECT
                                                </Button>
                                            </Col> 
                                        </>
                                    : post.status == 'REJECTED' ? 
                                        <>
                                            <Col md={6}>
                                                <Button color='secondary' block>Send Message</Button>
                                            </Col>
                                            
                                            <Col md={6}>
                                                <Button color='primary' block onClick={e => {
                                                    this.changeStatus(post.id, 'PENDING');
                                                }}>CONSIDERATE
                                                </Button>
                                            </Col>
                                        </>
                                    : <></>
                                    }
                                </Row>
                            </div>
                        </div>
                    </div>
                )}
            </Carousel>
        </div>

    profile_information = () =>
        <div className='general_information'>
            <Row>
                <Col md={4}>Bio</Col>
                <Col md={8}>{ this.state.user_selected.profile.description || '<Not specified>'} </Col>
            </Row>
            <Row>
                <Col md={4}>Gender</Col>
                <Col md={8}>{ this.state.user_selected.profile.gender === 0 ? '<Not Specified>' :
                    this.state.user_selected.profile.gender === 1 ? 'Male' : 'Female'}</Col>
            </Row>
            <Row>
                <Col md={4}>Age</Col>
                <Col md={8}>{`<Not Specified>`}</Col>
            </Row>
            <Row>
                <Col md={4}>Location</Col>
                <Col md={8}>{this.state.user_selected.profile.location || '<Not Specified>'}</Col>
            </Row>
            <Row>
                <Col md={4}>Contact Number</Col>
                <Col md={8}>{this.state.user_selected.profile.contact_number || '<Not Specified>'}</Col>
            </Row>
            <Row>
                <Col md={4}>Email</Col>
                <Col md={8}>{this.state.user_selected.profile.email || '<Not Specified>'}</Col>
            </Row>
            <Row>
                <Col md={4}>Social Media</Col>
                <Col md={8}>{this.state.user_selected.profile.social_media.map((sma, index) =>
                    <a href={`https://${Object.values(SOCIALMEDIA)[sma.type].name}.com/${sma.username}`} className='social_media' target="_blank" key={index} >
                        <img src={`${Object.values(SOCIALMEDIA)[sma.type].icon}`} />
                        <span>{ sma.username }</span>
                    </a>
                )}</Col>
            </Row>
            <Row>
                <Col md={4}>Categories</Col>
                <Col md={8}>{this.state.user_selected.profile.category ? 
                    this.state.user_selected.profile.category.map((cat, index) => 
                        <div className='category' key={index}>
                            {cat.description}
                        </div>
                    ) : 
                    '<Not Specified>'}</Col>
            </Row>
        </div>


    userContent = () => 
        <>
            <div className='profile_head'>
                <div className='view_profile_photo' 
                    style={{
                        backgroundImage: `url(${URL.SERVER}/${this.state.user_selected.profile.media ? 'storage/' + this.state.user_selected.profile.media.url : 'images/default_avatar.png'})`
                    }}>
                </div>
                <div className='view_profile_headinfo'>
                    <h2>{this.state.user_selected.profile.name}</h2>
                    <Rating rating={this.state.user_selected.profile.rating} averageVisible={true} countVisible={true} />
                </div>

            </div>
            <div className='profile_body'>
                <div className='profile_tab'>
                    { this.state.profileTab.map((tab, index) => 
                        <div className={`profile_tab_item ${this.state.activeProfileTab == index && 'active'}`}
                            onClick={ e => { this.setState({ activeProfileTab: index })}}
                            key={index}
                        >
                            { tab }
                        </div>
                    )}
                </div>
                
                <div className='profile_content'>
                    { this.setProfileTab() }
                </div>  

            </div>
        </>
                    
	list = () => 
        this.state[`user_${this.state.postTabs[this.state.activeUserPostTab].toLocaleLowerCase()}`] &&
        this.state[`user_${this.state.postTabs[this.state.activeUserPostTab].toLocaleLowerCase()}`].map(
            (user, index) =>
                <div className='custom_list_item' key={index}
                    onClick={ e => {
                        this.getUserPosts(user.id, this.state.socialMedia.id, this.state.postTabs[this.state.activeUserPostTab].toLocaleUpperCase());
                    }}
                >   
                    <div className='list_profile_photo' 
                        style={{backgroundImage: 
                            `url(${URL.SERVER}/${user.media ? 'storage/' + user.media.url : 'images/default_avatar.png'})`}}>
                    </div>
                    
                    <div className='list_profile_body'>
                        <div className='list_profile_name'>
                            {user.name}
                        </div>
                            <Rating rating={user.ratings} />
                        <div className='post_count'>
                            Post: {user.post_count}
                        </div>
                    </div>
                    

                </div>
    );
						
	render = () => 
		<div className='userpost_container'>
            
			<Row>
				<Col md='4'>
					<div className='custom_tab'>
                        <ul className='tab'>
							{ this.state.postTabs.map((tab, index) =>
								<li className={`custom_list_tab ${this.state.activeUserPostTab == index && 'active'}`} 
									key={index} 
                                    onClick={e => this.setState({ activeUserPostTab: index },
                                        () => {
                                            if(this.state[`user_${this.state.postTabs[this.state.activeUserPostTab].toLocaleLowerCase()}`].length > 0) {
                                                const user = this.state[`user_${this.state.postTabs[this.state.activeUserPostTab].toLocaleLowerCase()}`][0];
                                                this.getUserPosts(user.id, this.state.socialMedia.id, this.state.postTabs[this.state.activeUserPostTab].toLocaleUpperCase());
                                            } else {
                                                this.setState({ user_selected: null })
                                            }
                                        })}
								>
									{ tab }
								</li>
							)}
						</ul>
						<div className='custom_list'>
							{ this.list() }
						</div>
					</div>
				</Col>
				<Col md='8'>
					<div className='applicant_profile'>
                        { this.state.user_selected ? this.userContent() : 
                            <p className='no_post'>No post to show</p>
                        }
					</div>
				</Col>
			</Row>			
		</div>
}

