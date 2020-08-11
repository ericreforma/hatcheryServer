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

           

        </div>

}