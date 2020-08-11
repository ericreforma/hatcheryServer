import React, { Component } from 'react';
import CampaignFunction from '../../../functions/CampaignFunction';

import Applicants from './Applicants';

export default class EventDetails extends Component {
    constructor(props){
        super(props);

        this.state = {
            tabs: ['Applicants','Job Listing', 'Schedule', 'Details'],
            currentTab: 0,
            event: null,
        }
    }
    
    componentDidMount() {
        CampaignFunction.event.details(this.props.match.params.id)
        .then(response => {
            this.setState({
                event: response.data
            });
        })
        .catch( e => {
            console.log(e);
        })
    }

    setTabs = () => {
        switch(this.state.currentTab){
            case 0:
                return <Applicants event={this.state.event} />
        }
    }

    _handleChangeTab = tab => {
        this.setState({ currentTab: tab })
    }

    body = () => 
        this.state.event && 
        <>
            <h1 className='campaign_title'>{this.state.event.name}</h1>

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