import React, { Component } from 'react';
import { Row, Col, Table, Button } from 'reactstrap';
import moment from 'moment';

export default class Publish extends Component {
    constructor (props) {
        super(props);

        this.state = {
            forms: ['content' ,'costing'],
            content: this.props.parentState.content, 
            costing: this.props.parentState.costing,
        }
    }

    componentDidMount() {
        this.setState({
            content: this.props.parentState.content, 
            costing: this.props.parentState.costing,
        });
    }

    _handleClick = e => {
        e.preventDefault();
    }

    render() {
        let i = 0;
        return (

            <div className='campaign_create_summary'>
                <h1>Your event is ready!</h1>
                { console.log(this.state.costing.jobs)}
                <Row>
                    <Col md={{size: 10, offset: 1}}>
                        <div className='summary_body'>
                            <h4>Details</h4>
                            <div className='summary_content'>
                                <Row>
                                    <Col md="4">Campaign Name</Col>
                                    <Col md="8"><strong>{this.state.content.name}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Description</Col>
                                    <Col md="8"><strong>{this.state.content.description}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Image</Col>
                                    <Col md="8"><strong><img src={this.state.content.imagePreview}/></strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Venue</Col>
                                    <Col md="8"><strong>{this.state.content.venue}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Venue Address</Col>
                                    <Col md="8"><strong>{this.state.content.venue_address}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Estimated Audience</Col>
                                    <Col md="8"><strong>{this.state.content.est_audience}</strong></Col>
                                </Row>
                            </div>
                            <h4>Schedule</h4>
                            <div className='summary_content'>
                                <Row>
                                    <Col md="12" className='schedule_table'>
                                        <Table>
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Time</th>
                                                    <th>BreakTime</th>
                                                    <th>Work Hours</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                { this.props.parentState.content.schedule.map((date, index) => 
                                                    <tr key={index}>
                                                       <td> { moment(date.from).format('MMM. D, YYYY') }<br/>
                                                            <span>{ moment(date.from).format('dddd') }</span>
                                                        </td>
                                                        <td>
                                                            <div className='publish_time'>
                                                                {moment(date.from).format('hh:mm a')}
                                                            </div>
                                                            <div className='publish_time'>
                                                                {moment(date.to).format('hh:mm a')}
                                                            </div>
                                                        </td>
                                                        <td>
                                                            {date.breaktime}
                                                        </td>
                                                        <td>
                                                            {date.workhours}
                                                        </td>
                                                    </tr>
                                                )}
                                            </tbody>
                                        </Table>
                                    </Col>
                                </Row>
                                <Row>
                                    <Col md="4">Total Work Days</Col>
                                    <Col md="8"><strong>{this.state.content.days_total}</strong></Col>
                                </Row>
                                <Row>
                                    <Col md="4">Total Work Hours</Col>
                                    <Col md="8"><strong>{this.state.content.hours_total}</strong></Col>
                                </Row>
                            </div>
                            <h4>Job Costing</h4>
                            <div className='summary_content'>
                            <Row>
                                <Col md="12">
                                    <Table>
                                        <thead>
                                            <tr>
                                                <th>Job</th>
                                                <th>Skills</th>
                                                <th>Personnel</th>
                                                <th>Rate</th>
                                                <th>{this.state.content.days_total}-Day Job Cost </th>
                                                <th>Total Cost </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            { this.props.parentState.costing.jobs.map((val, index) => 
                                                <tr key={index}>
                                                    <td>{val.description}</td>
                                                    <td>
                                                        <ul className='publish_skill_container'>
                                                        { val.skills.map((skill, index) => 
                                                            <li key={index}>{skill.description}</li>
                                                        )}
                                                        </ul>
                                                    </td>
                                                    <td>{val.quantity}</td>
                                                    <td>Php {val.rate} / {(val.rate_unit).toUpperCase()}</td>
                                                    <td>Php {parseFloat(val.cost_per_individual).toLocaleString()}</td>
                                                    <td>Php {parseFloat(val.total_cost).toLocaleString()}</td>
                                                </tr>
                                            )}
                                        </tbody>
                                    </Table>
                                </Col>
                            </Row>
                            <Row>
                                <Col md={{size: 2, offset: 5}}>
                                    <Button block className='submitButton' color='success' onClick={() => this.props.publish() }>Publish</Button>
                                </Col>
                            </Row>
                            </div>
                        </div>

                    </Col>
                </Row>
            </div>



        )
    }
        
}