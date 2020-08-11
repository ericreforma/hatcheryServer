import React, { Component } from 'react';
import CampaignFunction from '../../../functions/CampaignFunction';

import Posts from './Posts';

export default class SocialMediaDetails extends Component {
    constructor(props){
        super(props);

        this.state = {
            tabs: ['Posts', 'Budget', 'Details'],
            currentTab: 0,
            socialMedia: null,
        }
    }
    
    componentDidMount() {
        CampaignFunction.socialmedia.details(this.props.match.params.id)
        .then(response => {
            this.setState({
                socialMedia: response.data
            });
        })
        .catch( e => {
            console.log(e);
        })
    }

    setTabs = () => {
        switch(this.state.currentTab){
            case 0:
                return <Posts socialMedia={this.state.socialMedia} />
        }
    }

    _handleChangeTab = tab => {
        this.setState({ currentTab: tab })
    }

    body = () => 
        this.state.socialMedia && 
        <>
            <h1 className='campaign_title'>{this.state.socialMedia.name}</h1>

            <div className='tab_container'>
                <div className='tab_navigation'>
                    { this.state.tabs.map( (tab, index) => 
                        <div 
                            className={`tab_menu ${ this.state.currentTab === index ? 'active' : ''}`} 
                            key={index}
                            onClick={() => this._handleChangeTab(index)}
                        >{tab}</div>
                    )}
                </div>
            </div>

            <div className='tab_content'>
                { this.setTabs() }
            </div>
        </>
    
    
    render = () => 
        <div className='campaign_details'>

           { this.body() }
            
        </div>
    

}