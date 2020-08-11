import React, { Component } from 'react';
import { Row, Col, Table, Button } from 'reactstrap';
import moment from 'moment';

export default class Publish extends Component {
    constructor (props) {
        super(props);

        this.state = {
            forms: ['content' ,'costing'],
            content: this.props.parentState.content, 
            jobs: this.props.parentState.jobs,
            scheduling: this.props.parentState.scheduling,
            images: this.props.parentState.images
        }
        this.updateWindowDimensions = this.updateWindowDimensions.bind(this);
    }

    componentDidMount() {
        this.updateWindowDimensions();
        window.addEventListener('resize', this.updateWindowDimensions);
        
        this.setState({
            content: this.props.parentState.content,
            jobs: this.props.parentState.jobs,
            scheduling: this.props.parentState.scheduling,
            images: this.props.parentState.images
        }, () => {
            console.log(this.state.scheduling)
        });
    }

    updateWindowDimensions() {
        this.setState({ width: window.innerWidth, height: window.innerHeight });
    }

    _handleClick = e => {
        e.preventDefault();
    }

    scheduleCard = (schedule, job) => {
        const index = this.state.scheduling.jobSchedule.findIndex(x => (x.job_id === job.id && x.schedule_date === schedule.date));
        const jobSched = this.state.scheduling.jobSchedule[index];
          
            return (
                <div className='scheduleCard'>
                    { 
                    <>
                        <div className='time'>
                            <div className='time_container'>
                                { moment(jobSched.schedule_from).format('h:mm a')} - { moment(jobSched.schedule_to).format('h:mm a')}
                                
                            </div>

                            <div className={`break`}>
                                <p>{jobSched.schedule_breaktime} mins break</p>
                                
                            </div>
                        </div>
                        <div className='totals'>
                            {jobSched.schedule_workhours} hrs / ${jobSched.schedule_rate}
                        </div>
                    </>
                    }
                </div>
            )
    }

    render() {
        let i = 0;
        return (

            <div className='campaign_create_summary'>
                <h1>Your event is ready!</h1>
                <Row>
                    <Col md={{size: 10, offset: 1}}>
                        <div className='summary_body'>
                            <h4>Details</h4>
                            <div className='summary_content'>
                                <Row>
                                    <Col md="4">Event Name</Col>
                                    <Col md="8"><strong>{this.state.content.name}</strong></Col>
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
                            
                            <h4>Event Schedule</h4>
                            <div className='summary_content'>
                                <Row>
                                    <Col md="12" className='schedule_table'>
                                        <Table>
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Time</th>
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
                                                                {moment(date.from).format('h:mm a')}
                                                            </div>
                                                            <div className='publish_time'>
                                                                {moment(date.to).format('h:mm a')}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                )}
                                            </tbody>
                                        </Table>
                                    </Col>
                                </Row>
                            </div>
                            <h4>Jobs</h4>
                                <div className='summary_content'>
                                    <Row>
                                        <Col md="12">
                                            <Table className={'jobsTable'}>
                                                <thead>
                                                    <tr>
                                                        <th>Job</th>
                                                        <th>Personnel</th>
                                                        <th>Skills</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                { this.state.jobs && this.state.jobs.map((j, index) => 
                                                        <tr key={index}>
                                                            <td>{j.description}</td>
                                                            <td>{ j.quantity }</td>
                                                            <td>{ 
                                                                j.skills.map((skill, skillIndex) => 
                                                                    <span key={skillIndex}>{skill.description}</span>
                                                                )
                                                            }</td>
                                                        </tr>
                                                )}
                                                </tbody>
                                            </Table>
                                        </Col>
                                    </Row>
                                    
                                </div>
                            <h4>Job Schedule</h4>
                            <div className='summary_content'>
                                <div className='jobScheduleTable_jobColumn'>
                                    <div className='jobScheduleTable_jobColumn_ jobScheduleTable_jobColumn_title'>
                                    </div>
                                    { this.state.scheduling.jobs && this.state.scheduling.jobs.map((job, job_index) =>
                                    
                                        <div className='jobScheduleTable_jobColumn_' key={job_index}>
                                            <p className='jobScheduleTable_jobColumn_description'>{ job.description }</p>
                                            <p className='jobScheduleTable_jobColumn_rate'>${ job.rate } / HR</p>
                                            <p>{ parseFloat(job.total_hours).toFixed(2).toString() } / ${parseFloat(job.total_cost).toFixed(2).toString()}</p>
                                            
                                        </div>
                                    )}
                                </div>
                                <div className={'jobScheduleTable'} style={{ width: `${this.state.width - 833}px`}}>

                                    <div className='jobScheduleTable_head' style={{ width: `${200 * this.state.scheduling.schedule.length}px`}}>
                                        { this.state.scheduling.schedule.map((schedule, index)=>
                                            <div key={index}>
                                                <p>{ moment(schedule.date).format("ddd, MMM D") }</p>
                                                <p>${ schedule.total_cost }</p>
                                            </div>
                                        )}
                                    </div>
                                    <div className='jobScheduleTable_body'>
                                        { this.state.scheduling.jobs && this.state.scheduling.jobs.map((job, job_index) =>
                                            <div className='jobScheduleTable_body_row' style={{ width: `${200 * this.state.scheduling.schedule.length}px`}} key={job_index}>
                                                { this.state.scheduling.schedule && this.state.scheduling.schedule.map( (schedule, sched_index) => 
                                                    <div key={`${job_index}${sched_index}`}>
                                                        { this.scheduleCard(schedule, job) }
                                                    </div>
                                                ) }
                                            </div>
                                        )}
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </Col>
                </Row>
                <Row>
                    <Col md={{size: 2, offset: 5}}>
                        <br />
                        <Button block className='submitButton' color='success' onClick={() => this.props.publish() }>Publish</Button>
                        <br />
                        <br />
                        <br />
                    </Col>
                </Row>
            </div>



        )
    }
        
}