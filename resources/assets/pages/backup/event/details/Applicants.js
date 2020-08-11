import React, { Component } from 'react';
import { Row, Col, Button } from 'reactstrap';
import Rating from '../../../elements/Rating';
import { CampaignFunction } from '../../../functions';
import URL from '../../../config/url';
import { SOCIALMEDIA } from '../../../config/variables';
import moment from 'moment';

export default class Applicants extends Component {
    constructor(props){
        super(props);
        this.state = {
            event: this.props.event,

            applicantTabs: ['Pending','Accepted', 'Rejected'],
            profileTab:['Profile','Application History', 'Reviews'],
            activeProfileTab: 0,
            activeApplicantTab: 0,
            applicant: null,
            profile: null,
            requestsCount: this.props.event.applicants.filter(a => a.status == 'PENDING').length,
            acceptedCount: this.props.event.applicants.filter(a => a.status == 'ACCEPTED').length,
            rejectedCount: this.props.event.applicants.filter(a => a.status == 'REJECTED').length
        }
    }

    applicantItem = (applicant, key) => 
        <div className='custom_list_item' key={key}
            onClick={e => {
                this.getProfile(applicant.id, applicant.eventjob_id, applicant.profile.id);
            }}
        >   
            <div className='list_profile_photo' 
                style={{backgroundImage: 
                    `url(${URL.SERVER}/${applicant.profile.media ? 'storage/' + applicant.profile.media.url : 'images/default_avatar.png'})`}}>
            </div>

            <div className='list_profile_body'>
                <div className='list_profile_name'>
                    {applicant.profile.name}
                </div>
                <Rating rating={applicant.profile.rating} />
                <div className='list_job_title'>
                    {applicant.job.job_description}
                </div>
            </div>
        </div>
    
    requestedList = () => 
        this.state.event.applicants && 
        this.state.event.applicants.filter(a => a.status == 'PENDING').map((applicant, index) => 
            this.applicantItem(applicant, index)
        )

    acceptedList = () => 
        this.state.event.applicants && 
        this.state.event.applicants.filter(a => a.status == 'ACCEPTED').map((applicant, index) => 
            this.applicantItem(applicant, index)
        )
    

    rejectedList = () =>
        this.state.event.applicants && 
        this.state.event.applicants.filter(a => a.status == 'REJECTED').map((applicant, index) => 
            this.applicantItem(applicant, index)
        )

    setProfileTab = () => {
        switch(this.state.activeProfileTab){
            case 0:
                return this.profile_information()
            case 2:
                return this.profile_rating()
        }
    }

    getProfile = (event_applicant_id, eventjob_id, user_id) => {
        CampaignFunction.event.applicant.profile(event_applicant_id, eventjob_id, user_id)
        .then( response => {
            this.setState({ applicant: response.data })
        })
        .catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        })
    }

    profile_information = () =>
        <div className='general_information'>
            <Row>
                <Col md={4}>Bio</Col>
                <Col md={8}>{ this.state.applicant.profile.description || '<Not specified>'} </Col>
            </Row>
            <Row>
                <Col md={4}>Gender</Col>
                <Col md={8}>{ this.state.applicant.profile.gender === 0 ? '<Not Specified>' :
                    this.state.applicant.profile.gender === 1 ? 'Male' : 'Female'}</Col>
            </Row>
            <Row>
                <Col md={4}>Age</Col>
                <Col md={8}>{`<Not Specified>`}</Col>
            </Row>
            <Row>
                <Col md={4}>Location</Col>
                <Col md={8}>{this.state.applicant.profile.location || '<Not Specified>'}</Col>
            </Row>
            <Row>
                <Col md={4}>Contact Number</Col>
                <Col md={8}>{this.state.applicant.profile.contact_number || '<Not Specified>'}</Col>
            </Row>
            <Row>
                <Col md={4}>Email</Col>
                <Col md={8}>{this.state.applicant.profile.email || '<Not Specified>'}</Col>
            </Row>
            <Row>
                <Col md={4}>Social Media</Col>
                <Col md={8}>{this.state.applicant.profile.social_media.map((sma, index) =>
                    <a href={`https://${Object.values(SOCIALMEDIA)[sma.type].name}.com/${sma.username}`} className='social_media' target="_blank" key={index} >
                        <img src={`${Object.values(SOCIALMEDIA)[sma.type].icon}`} />
                        <span>{ sma.username }</span>
                    </a>
                )}</Col>
            </Row>
            <Row>
                <Col md={4}>Categories</Col>
                <Col md={8}>{this.state.applicant.profile.category ? 
                    this.state.applicant.profile.category.map((cat, index) => 
                        <div className='category' key={index}>
                            {cat.description}
                        </div>
                    ) : 
                    '<Not Specified>'}</Col>
            </Row>
        </div>

    profile_rating = () =>
        <div className='profile_rating'>
            { this.state.applicant.profile.ratings.map((rating, index) => 
                <div className='client_rating' key={index}>
                    <div className='client_profile'>
                        <img src={`${rating.client_media ? 'storage/' + rating.client_media.url : URL.SERVER + '/images/default_avatar.png'}`} />
                        <span>{rating.client_name}</span>
                    </div>
                    <div className='client_rate'>
                        <Rating rating={{ total: 0, count: 0, average: rating.rate }} />
                    </div>
                    <p>{rating.comment}</p>
                    <div className='rate_date'>
                        {moment(rating.created_at).format('MMM. D, YYYY hh:mm a')}
                    </div>
                </div>
            )}
        </div>

    setStatus = (status, activeApplicantTab) => {
        console.log(this.state.applicant.id)
        CampaignFunction.event.applicant.setStatus(
            this.state.applicant.jobApplication.id,
            status
        ).then(response => {
            this.refresh(activeApplicantTab);
        }).catch(e => {
            console.log(e);
            console.log(e.response.data);
            console.log(e.response.status);
            console.log(e.response.headers);
        })
    }
    refresh = activeApplicantTab => {
        CampaignFunction.event.details(this.state.event.id)
        .then(response => {
            this.setState({
                event: response.data,
                requestsCount:  response.data.applicants.filter(a => a.status == 'REQUESTED').length,
                acceptedCount:  response.data.applicants.filter(a => a.status == 'ACCEPTED').length,
                rejectedCount:  response.data.applicants.filter(a => a.status == 'REJECTED').length,
                activeApplicantTab,
                applicant: null
            }, () => {
                
            });
        })
        .catch( e => {
            console.log(e);
        })
    }
    viewProfile = () => 
        <>
            <div className='profile_head'>
                <div className='view_profile_photo' 
                    style={{
                        backgroundImage: `url(${URL.SERVER}/${this.state.applicant.profile.media ? 'storage/' + this.state.applicant.profile.media.url : 'images/default_avatar.png'})`
                    }}>
                </div>
                <div className='view_profile_headinfo'>
                    <h2>{this.state.applicant.profile.name}</h2>
                    <Rating rating={this.state.applicant.profile.rating} averageVisible={true} countVisible={true} />
                    <h5>{this.state.applicant.eventjob.job_description}</h5>
                    <div className='button_container'>
                        { this.state.applicant.jobApplication.status == 'REJECTED' ?
                            <Button color='warning' onClick={() => {
                                this.setStatus('REQUESTED', 0);
                            }}>MOVE TO REQUESTS</Button>
                        :
                        this.state.applicant.jobApplication.status == 'ACCEPTED' ? 
                            <Button color='warning' onClick={() => {
                                this.setStatus('REQUESTED', 0);
                            }}>REVOKE</Button>
                        :
                            <>
                                <Button color='primary' onClick={() => {
                                    this.setStatus('ACCEPTED', 1);
                                }}>ACCEPT</Button>
        
                                <Button color='link' onClick={() => {
                                    this.setStatus('REJECTED', 2);
                                }}>REJECT</Button>
                            </>
                        }
                        
                        
                    </div>
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

    render = () => 
        <div className='event_applicants'>
            <Row>
                <Col md='4'>
                    <div className='custom_tab'>
                        <ul className='tab'>
                            { this.state.applicantTabs.map((tab, index) =>
                                <li className={`custom_list_tab ${this.state.activeApplicantTab == index && 'active'}`} 
                                    key={index} 
                                    onClick={e => this.setState({ activeApplicantTab: index })}
                                >
                                    { tab } <span>({this.state[`${tab.toLowerCase()}Count`]})</span>
                                </li>
                            )}
                        </ul>
                        <div className='custom_list'>
                            { this.state.activeApplicantTab === 0 ? 
                                this.requestedList() :
                                this.state.activeApplicantTab === 1 ? 
                                this.acceptedList() :
                                this.rejectedList()
                            }
                        </div>
                    </div>

                </Col>
                <Col md='8'>
                    <div className='applicant_profile'>
                        { this.state.applicant ? this.viewProfile() : 
                            <p> Select a proflile</p>
                        }
                    </div>
                </Col>
            </Row>
        </div>
}