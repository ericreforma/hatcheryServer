import React, { Component } from 'react';
import { Row, Col, Button } from 'reactstrap';
import { CampaignFunction, InfluencerFunction } from '../../../functions';
import URL from '../../../config/url';

export default class Influencers extends Component {
    constructor(props){
        super(props);
        this.state = {
            list: [],
            selected: 0,
            profile: {}
        }
    }
    
    componentDidMount() {
        CampaignFunction.information.influencers(this.props.id)
        .then( (response) => {
            this.setState({
                list: response.data
            });
        })
        .catch( e => {
            console.log(e);
        })
    }

    _fetchProfile = id => {
        InfluencerFunction.profile(id)
        .then( response => {
            this.setState({ profile: response.data });
        })
        .catch( e => {
            
        });
    }

    profile = () => {
        if(Object.entries(this.state.profile).length !== 0){
            return ( 
            <div className='influencer_profile'>
                <div className="profile_head">
                    <div className="photo" 
                        style={{backgroundImage: `url("${URL.SERVER}/images/avatar${(Math.floor(Math.random() * 6)) + 1}.jpeg")`}}>
                    </div>
                    <div className="name">
                        <h4>{this.state.profile.name}</h4>
                        <span>{this.state.profile.username}</span>
                    </div>
                </div>

                <div className='profile_body'>
                    
                </div>
                
            </div>
            );
        } else {
            return (<div className='empty'>Select a collaborator</div>);
        }
    }

    render = () => 
        <div className='campaign_influencers'>
            <Row>
                <Col md="4">
                    <div className='influencer_list'>

                        { this.state.list.map( (influencer, index) => 
                            <div className="influencer_item" key={index} onClick={ () => { this._fetchProfile(influencer.id) }}>
                                <div className="photo" 
                                style={{backgroundImage: `url("${URL.SERVER}/images/avatar${(Math.floor(Math.random() * 6)) + 1}.jpeg")`}}>
                                </div>
                                <div className="name">
                                    <h4>{influencer.name}</h4>
                                    <span>{influencer.username}</span>
                                </div>
                            </div>
                        )}

                    </div>
                </Col>
                <Col md="8">
                    <div className='influencer_details_container'>
                        { this.profile() }
                    </div>
                </Col>
            </Row>
        </div>
}