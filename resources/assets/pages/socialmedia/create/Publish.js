import React, { Component } from 'react';
import { Row, Col, Table, Button } from 'reactstrap';
import moment from 'moment';

import { GENDER, SOCIALMEDIA, CAMPAIGN_TYPE, ENGAGEMENT} from '../../../config/variables';

export default class Publish extends Component {
    constructor (props) {
        super(props);

        this.state = {
            images: [],
            forms: ['content', 'budget'],
            content: {},
            budget: {}
        }
    }

    componentDidMount() {
        this.setState({
            images: this.props.parentState.images,
            content: this.props.parentState.content, 
            budget: this.props.parentState.budget
        });
    }

    _handleClick = e => {
        e.preventDefault();
    }

    render() {
        let i = 0;
        return (

            <div className='campaign_create_summary'>
                <h1>Your campaign is ready!</h1>
                <Row>
                    <Col md={{size: 10, offset: 1}}>
                        <div className='summary_body'>
                            <h4>content</h4>
                            <div className='summary_content'>
                                <Row>
                                    <Col md="4">Campaign Name</Col>
                                    <Col md="8"><strong>{this.state.content.name}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Social Media</Col>
                                    <Col md="8">
                                        {this.props.parentState.content.socialMedia.map((sm, index) =>  
                                            <li className='socialMedia' key={index}>
                                                <div><img src={sm.icon} />{sm.prettyname}</div>
                                            </li>
                                        )}
                                    </Col>
                                </Row>
                                <Row>
                                    <Col md="4">Description</Col>
                                    <Col md="8"><strong>{this.state.content.description}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Image</Col>
                                    <Col md="8">
                                        { this.state.images && this.state.images.map((img, index) => 
                                            <img src={window.webkitURL.createObjectURL(img)} />
                                        )}
                                        
                                    </Col>
                                </Row>
                                <Row>
                                    <Col md="4">Hash Tags</Col>
                                    <Col md="8"><strong>
                                        {this.props.parentState.content.hashtag.map((hashtag, index) => 
                                            <div className='summary_hashtag' key={index}>{hashtag}</div>
                                        )}
                                        </strong>
                                    </Col>
                                </Row>
                                <Row>
                                    <Col md="4">Mentions</Col>
                                    <Col md="8"><strong>
                                        {this.props.parentState.content.mentions.map((mention, index) => 
                                            <div className='summary_mentions' key={index}>{mention}</div>
                                        )}
                                        </strong>
                                    </Col>
                                </Row>
                            </div>
                            <h4>Requirements</h4>
                            <div className='summary_content'>
                                <Row>
                                    <Col md="4">Gender</Col>
                                    <Col md="8"><strong>{GENDER[this.state.content.gender - 1]}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Categories</Col>
                                    <Col md="8"><div className="category_container">{
                                        this.props.parentState.content.categories.map( (cat, index) => 
                                            <div className="category" key={index}>{cat.description}</div>
                                        )
                                    }</div></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Followers</Col>
                                    <Col md="8"><strong>{parseInt(this.state.content.followers).toLocaleString(undefined, {maximumFractionDigits:0})}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Deadline of submission</Col>
                                    <Col md="8"><strong>{moment(this.state.content.deadline).format('MMM DD YYYY h:mm:ss a')}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Age</Col>
                                    <Col md="8"><strong>{this.props.parentState.content.age_range[0]} - {this.props.parentState.content.age_range[1]}</strong></Col>
                                </Row>
                            </div>
                            <h4>Budget</h4>
                            <div className='summary_content'>
                            <Row>
                                <Col md="4">Campaign Budget</Col>
                                <Col md="8"><strong>Php {parseFloat(this.state.budget.budget).toLocaleString(undefined, {maximumFractionDigits:2})}</strong></Col>
                            </Row>
                            <Row>
                                <Col md="4">Collaborators</Col>
                                <Col md="8"><strong>{this.state.budget.collaborator_count}</strong></Col>
                            </Row>
                            <Row>
                                <Col md="4">Budget for each Collaborator</Col>
                                <Col md="8"><strong>Php {parseFloat(this.state.budget.collaborator_budget).toLocaleString(undefined, {maximumFractionDigits:2})}</strong></Col>
                            </Row>

                            <Row>
                                <Col md="4">Basic Pay</Col>
                                <Col md="8"><strong>Php {parseFloat(this.state.budget.basic_pay).toLocaleString(undefined, {maximumFractionDigits:2})}</strong></Col>
                            </Row>

                            <Row>
                                <Col md="4">Engagement Budget for each Collaborator</Col>
                                <Col md="8"><strong>Php {parseFloat(this.state.budget.engagement_budget).toLocaleString(undefined, {maximumFractionDigits:2})}</strong></Col>
                            </Row>
                            
                            <Row>
                                <Col md="12">
                                    <Table>
                                        <thead>
                                            <tr>
                                                <th>Engagement</th>
                                                <th>Range</th>
                                                <th>Cost per unit</th>
                                                <th>Total Cost</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            { ENGAGEMENT.map((type, index) => {
                                                if(this.state.budget[`${type.toLowerCase()}s_selected`]){
                                                    i++;
                                                    return (
                                                        <tr key={index}>
                                                            <td>{type}s</td>
                                                            <td>{parseInt(this.state.budget[`${type.toLowerCase()}s_min`]).toLocaleString(undefined, {maximumFractionDigits:2})} - 
                                                                {parseInt(this.state.budget[`${type.toLowerCase()}s_max`]).toLocaleString(undefined, {maximumFractionDigits:2})}</td>
                                                            <td>Php {this.state.budget[`${type.toLowerCase()}s_per_unit`]} / {type.toLowerCase()}</td>
                                                            <td>Php {parseFloat(this.state.budget[`${type.toLowerCase()}s_cost`]).toLocaleString(undefined, {maximumFractionDigits:2})}</td>
                                                        </tr>
                                                    )
                                                }
                                            })}
                                        </tbody>
                                    </Table>
                                </Col>
                            </Row>

                            {(i===0) && 
                                <div>No budget defined.</div>
                            }
                            </div>
                            <Button block className='submitButton' color='success' onClick={() => this.props.publish() }>Publish</Button>
                        </div>

                    </Col>
                </Row>
            </div>



        )
    }
        
}