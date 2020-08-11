import React, { Component } from 'react';
import {
    Row,
    Col,
    Label,
    Input,
    InputGroup,
    Button,
    InputGroupAddon,
    FormGroup,
} from 'reactstrap';
import CategoryInput from '../../../elements/CategoryInput';

export default class Budget extends Component {
    constructor(props) {
        super(props);

        this.state= {
            workDays: this.props.parentState.content.days_total,
            // workDays: 5,
            workHours: this.props.parentState.content.hours_total,
            // workHours: 8,
            jobs: this.props.parentState.costing.jobs,
            job_selected: 0,
            skill_list: [],
            overallCost: 0
        }
    }

    componentDidMount() {
        this.setState({
            overallCost: this.props.parentState.costing.overallCost || 0,
            jobs: this.props.parentState.costing.jobs || [],
        }, () => {
            let overallCost = 0;
            this.state.jobs.map(val => {
                overallCost += val.total_cost;
            }); 
            this.setState({ overallCost });
        });
    }
  
    _handleOnChange = (value, input) => {
        if(type == 'number') {
            value = this.number(value);
        }

        this.setState({
            [input]: value
        }, () => {
            this.sendToParent();
        });
    }

    sendToParent = () => {
        this.props.sendStateToParent({
            costing: {
                jobs: this.state.jobs,
                overallCost: this.state.overallCost,
            }
        });
    }

    number = (num) => parseFloat(num.split(',').join(''));

    addJob = () => {
        const jobs = this.state.jobs;
        const isExist = jobs.find(job => job.id == this.state.job_selected);
        
        if(!isExist) {

            const selectedJob = this.props.jobList.find(job => job.id == this.state.job_selected);

            jobs.push({
                id: selectedJob.id,
                description: selectedJob.description,
                skills: [],
                quantity: 1,
                rate: 0,
                rate_unit: 'day',
                workhours_per_day: this.state.workHours,
                cost_per_individual: 0,
                total_cost: 0
            });

            
            this.setState({
                jobs,
                job_selected: 0 
            }, () => {
                this.sendToParent();
            });
        } else {
            console.log('exist!');
        }

    }   

    removeJob = (job) => {
        let filteredjob = this.state.jobs.filter(j => j.id != job.id);

        this.setState({
            jobs: filteredjob,
        }, () => {
            let overallCost = 0;
            this.state.jobs.map(val => {
                overallCost += val.total_cost;
            }); 
            this.setState({ overallCost }, () => {
                this.sendToParent();
            });
        });
    }

    changeValue = (value) => {
        let filteredValue = this.state.jobs.filter(v => v.job_id != value.job_id);

        if(value.rate_unit == 'day'){
            value.cost_per_individual = value.rate * this.state.workDays;
        }  else {
            value.cost_per_individual = (value.rate *  value.workhours_per_day) * this.state.workDays;
        }
        
        value.total_cost = value.cost_per_individual * value.quantity;

        this.setState({ value: filteredValue.push(value) },
        () => {
            let overallCost = 0;
            this.state.jobs.map(val => {
                overallCost += val.total_cost;
            }); 
            this.setState({ overallCost }, () => {
                this.sendToParent();
            });
        });
    }

    _handleChangeSkill = (job_id, skills) => {
        let jobs = this.state.jobs;
        jobs &&
            jobs.forEach(function(val, index){
                if(this[index].id === job_id) {
                    this[index].skills = skills
                }
            },jobs);
        
        this.setState({ jobs }, 
            () => {
                this.sendToParent();
        });
    }

    viewJobs = () => 
        this.state.jobs && this.state.jobs.map((job, index) => 
           
            <Row className='costing-row' key={index}>
                    <Col md="4">
                        <div className='job-title'>{job.description}</div>
                        <CategoryInput
                            categoryList={this.props.skillList} 
                            categories={this.state.jobs[index] ? this.state.jobs[index].skills : []}
                            id={job.id}
                            placeholder='Click to add skills'
                            onChange={(skills, id) => {
                                this._handleChangeSkill(job.id, skills);
                            }}
                        />

                        
                    </Col>
                    <Col md="1">
                        <Input type='number' value={job.quantity} 
                            onChange={e => {
                                job.quantity = e.target.value;
                                this.changeValue(job);
                            }}
                        />
                    </Col>
                    <Col md="3">
                        <div className='rate-container'>
                            <div className='currency'>P</div>
                            <Input type='number' value={job.rate} className='input_ratevalue'
                                onChange={e => {
                                    job.rate = e.target.value;
                                    this.changeValue(job);
                                }}
                            />
                            <Input type='select' value={job.rate_unit} className='input_rate'
                                onChange={e => {
                                    job.rate_unit = e.target.value;
                                    this.changeValue(job);
                                }}
                            >
                                <option value='day'>per Day</option>
                                <option value='hour'>per Hour</option>
                            </Input>
                        </div>
                    </Col>
                    <Col md="2">
                        <Input type='number' value={job.workhours_per_day} 
                            onChange={e => {
                                job.workhours_per_day = e.target.value;
                                this.changeValue(job);
                            }}
                        />
                    </Col>
                   
                    <Col md="2">
                    
                        <div className="jobcost_container">
                            <div className="cost">
                                <div className='label'>
                                    {this.state.workDays}-Day Cost
                                </div>
                                <div className='value'>
                                    Php {parseFloat(job.cost_per_individual).toLocaleString()}
                                </div>
                            </div>

                            <div className="cost">
                                <div className='label'>
                                    Total
                                </div>
                                <div className='value'>
                                    Php {parseFloat(job.total_cost).toLocaleString()}
                                </div>
                            </div>
                        </div>
                        <a href="#" onClick={e => {
                            e.preventDefault();
                            this.removeJob(job);
                        }}>remove</a>
                    </Col>
                    
                </Row>
        )
    
    jobList = () => {
        let options = [];
        this.props.jobList.map((skill, index) => {
            if(!this.state.jobs || this.state.jobs.filter(labor => labor.id == skill.id).length == 0){
                options.push(<option key={index} value={skill.id}>{skill.description}</option>);
            }
        });
        return options;
    }
    
    render = () => 
        
        <div className='event_jobCosting'>
            
            <FormGroup>
                <Row>
                    <Col md={4}>
                        <Label>Select a Job</Label>
                        <InputGroup>
                            <Input type='select' value={this.state.job_selected} onChange={e => this.setState({ job_selected: e.target.value })}>
                            <option value='0'> - </option>
                            { this.jobList() }
                            </Input>
                            <InputGroupAddon addonType="append">
                                <Button color='primary' onClick={e => {
                                    this.state.job_selected !== 0 && this.addJob()
                                }}>Add</Button>
                            </InputGroupAddon>
                        </InputGroup>
                    </Col>
                </Row>
            </FormGroup>

            <div className='job-costing-header'>
                <Row>
                    <Col md="4">Skills</Col>
                    <Col md="1">Personnel</Col>
                    <Col md="3">Rate</Col>
                    <Col md="2">Hours per day</Col>
                    <Col md="2">Job Cost</Col>
                </Row>
            </div>
            
            { !this.state.jobs || this.state.jobs.length > 0 ? this.viewJobs() :
                <div className='empty_job'>
                    <p>Select a job to start costing</p>
                </div> }
            
            <div className='overall_cost_container'>
                <FormGroup>
                    <Row className="costing-header">
                        <Col md="8"></Col>
                       
                    </Row>
                </FormGroup>

                <FormGroup>
                    <Row>
                        <Col md="8"></Col>
                        <Col md="4">
                            <div>Overall Cost</div>
                            <div className="overallCost">Php {parseFloat(this.state.overallCost).toLocaleString()}</div>
                        </Col>
                    </Row>
                </FormGroup>
                                    
                <FormGroup>
                    <Row>
                        <Col md="8"></Col>
                        <Col md="4">
                            <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                                NEXT
                            </Button>
                        </Col>
                    </Row>
                </FormGroup>
            </div>
            
            
            
            
        </div>
}

