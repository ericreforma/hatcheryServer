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

export default class Jobs extends Component {
    constructor(props) {
        super(props);

        this.state= {
            jobs: this.props.parentState.jobs,
            job_selected: 0,
            skill_list: [],
            overallCost: 0
        }
    }

    componentDidMount() {
        this.setState({
            jobs: this.props.parentState.jobs || [],
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
            jobs: this.state.jobs,
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
                rate_unit: 'hr',
            });

            
            this.setState({
                jobs,
                job_selected: 0 
            }, () => {
                this.sendToParent();
            });
        } 

    }   

    removeJob = (job) => {
        let filteredjob = this.state.jobs.filter(j => j.id != job.id);

        this.setState({
            jobs: filteredjob,
        }, () => {
            this.sendToParent();
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
    changeValue = (value) => {
        let filteredValue = this.state.jobs.filter(v => v.job_id != value.job_id);
        this.setState({ value: filteredValue.push(value) });
    }
    viewJobs = () => 
        this.state.jobs && this.state.jobs.map((job, index) => 
            <Row className='costing-row' key={index} style={{ zIndex: 100 - parseInt(index)}}>
                <Col md="2">
                    <div className='job-title'>{job.description}</div>
                </Col>
                <Col md="1">
                    <Input type='number' value={job.quantity} 
                        onChange={e => {
                            job.quantity = e.target.value;
                            this.changeValue(job);
                        }}
                    />
                </Col>
                <Col md="7">
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
                
                <Col md="2">
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
                    <Col md="2">Job</Col>            
                    <Col md="1">Personnel</Col>
                    <Col md="7">Skills</Col>
                    <Col md="2"></Col>
                </Row>
            </div>
            
            { !this.state.jobs || this.state.jobs.length > 0 ? this.viewJobs() :
                <div className='empty_job'>
                    <p>Empty Job</p>
                </div> }
            <FormGroup>
                <Row>
                    <Col md="8"></Col>
                    <Col md="4">
                        <br />
                        <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                            NEXT
                        </Button>
                    </Col>
                </Row>
            </FormGroup>
        </div>
}

