import React, { Component } from 'react';
import { ENGAGEMENT } from '../../../config/variables';
import { Row, Col, Button } from 'reactstrap';

export default class Dashboard extends Component {
    constructor(props) {
        super(props);
        this.state = {
            sm_icons: [
                'far fa-thumbs-up',
                'far fa-comment',
                'fas fa-share',
                'far fa-eye'
            ],
        }
    }

    componentDidMount() {

    }

    render = () =>
        <div className='campaign_dashboard'>
            <Row className='engagement'>
                { ENGAGEMENT.map( (type, index) => 
                    <Col md="3" key={index}>
                        <div className='engagement_card'>
                            <div className='engagement_count'>{Math.floor(Math.random() * 100)}</div>
                            <div className='engagement_name'>
                                <i className={this.state.sm_icons[index]}></i>
                                {type}s
                            </div>
                        </div>
                    </Col>
                )}
            </Row>
        </div>

}