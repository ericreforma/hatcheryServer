import React, { Component } from 'react';
import { FormGroup, Button } from 'reactstrap';
import TimeSelect from '../../../elements/TimeSelect';
import moment from 'moment';

export default class Scheduling extends Component {
    constructor(props){
        super(props);

        this.state = {
            width: 0,
            height: 0,
            schedule: [],
            jobs: [],
            jobSchedule: [],

            mouseOverDate: null
        }

        this.table = React.createRef();
        this.updateWindowDimensions = this.updateWindowDimensions.bind(this);
    }

    componentDidMount() {
        this.updateWindowDimensions();
        window.addEventListener('resize', this.updateWindowDimensions);
        this.setState({ 
            schedule: this.props.parentState.scheduling.schedule || this.props.parentState.content.schedule,
            jobs: this.props.parentState.scheduling.jobs || this.props.parentState.jobs,
            jobSchedule: this.props.parentState.scheduling.jobSchedule || null
        }, () => {
            console.log(this.state.jobs);

            if(this.state.jobSchedule == null)
                this.initializeBudget();
        });
    }

    updateWindowDimensions() {
        this.setState({ width: window.innerWidth, height: window.innerHeight });
    }

    sendToParent = () => {
        this.props.sendStateToParent({
            scheduling: {
                schedule: this.state.schedule,
                jobs: this.state.jobs,
                jobSchedule: this.state.jobSchedule,
            }
        });
    }

    initializeBudget = () => {
        const jobSchedule = [];
        let i = 0;

        this.state.jobs && this.state.jobs.map((job, index) =>
            { this.state.schedule && this.state.schedule.map( (schedule, index) => {
                const jobSched = {
                    id: i,
                    job_id: job.id,
                    job_description: job.description,
                    schedule_date: schedule.date,
                    schedule_from: schedule.from,
                    schedule_to: schedule.to,
                    schedule_workhours: 8,
                    schedule_breaktime: 60,
                    schedule_rate: 0,
                    quantity: job.quantity,
                    rate_cost: 0,
                    rate_unit: 0,
                    rate_total_hours: 0,
                    rate_total_cost: 0,
                    isRemoved: false
                };
                i++;
                jobSchedule.push(jobSched);
            })}
        );

        this.setState({ jobSchedule }, () => {
            this.sendToParent()
        });
    }

    changeScheduleTime = (target, time, index) => {
        const jobSchedule = this.state.jobSchedule;
        const jobSched = jobSchedule[index];
        jobSched[target] = time;
        const duration = moment.duration(moment(jobSched.schedule_to).diff(moment(jobSched.schedule_from)));
        jobSched.schedule_workhours = duration.asHours() - (jobSched.schedule_breaktime / 60);
        jobSched.schedule_rate = jobSched.schedule_workhours * jobSched.rate_cost;
        jobSched.rate_total_cost = jobSched.schedule_rate * jobSched.quantity;

        jobSchedule[index] = jobSched;

        this.updateDateAndJobCost(jobSched.job_id,
            (jobs, schedule) => {
                this.setState({ jobSchedule, schedule, jobs }, () => {
                    this.sendToParent()
                });
            });
    }
    
    updateDateAndJobCost = (job_id, callback) => {
        const jobSchedule = this.state.jobSchedule;

        // DATE RATE
            const schedule = this.state.schedule;

            schedule.map((sched, index) => {
                let scheduleTotalCost = 0;
                let rateTotalCost = 0;

                jobSchedule.filter(b => b.schedule_date == sched.date)
                .map(budg => {
                    if(!budg.isRemoved) {
                        scheduleTotalCost += parseFloat(budg.rate_total_cost);
                        
                    }
                })
                schedule[index].total_cost = scheduleTotalCost;
            });

        // JOB RATE AND COST
            const jobs = this.state.jobs;
            const jobIndex = this.state.jobs.findIndex(j => j.id == job_id);
            let jobTotalCost = 0;
            let jobTotalWorkHours = 0;
            const filteredJobSchedule = jobSchedule.filter(x => (x.job_id == job_id));

            filteredJobSchedule.map((jobSched, index) => {
                if(!jobSched.isRemoved) {
                    jobTotalCost += parseFloat(jobSched.schedule_rate);
                    jobTotalWorkHours += parseFloat(jobSched.schedule_workhours);
                }
            });
            jobs[jobIndex].total_cost = jobTotalCost * jobs[jobIndex].quantity;
            jobs[jobIndex].total_hours = jobTotalWorkHours;

        callback(jobs, schedule);
    }

    changeRate = (job_id, rate) => {
        const jobSchedule =  this.state.jobSchedule;
        const filteredJobSched = jobSchedule.filter(x => (x.job_id === job_id));
        let totalCost = 0;

        const jobss = this.state.jobs;
        const jobIndex = this.state.jobs.findIndex(j => j.id == job_id);
        jobss[jobIndex].rate = rate;
        this.setState({ jobs: jobss })

        filteredJobSched.map((jobSched, index) => {
            jobSched.rate_cost = rate;
            jobSched.schedule_rate = jobSched.schedule_workhours * rate;
            jobSched.rate_total_cost = jobSched.schedule_rate * jobSched.quantity;
            totalCost += parseFloat(jobSched.schedule_rate);

            const mainIndex = jobSchedule.findIndex(x => (x.id === jobSched.id));
            jobSchedule[mainIndex] = jobSched;
        });

        this.updateDateAndJobCost(job_id,
            (jobs, schedule) => {
                this.setState({ jobSchedule, schedule, jobs }, () => {
                    this.sendToParent();
                });
            });
    }

    changeQuantity = (job_id, quantity) => {
        const jobSchedule =  this.state.jobSchedule;
        const filteredJobSched = jobSchedule.filter(x => (x.job_id === job_id));
        let totalCost = 0;

        const jobss = this.state.jobs;
        const jobIndex = this.state.jobs.findIndex(j => j.id == job_id);
        jobss[jobIndex].quantity = quantity;
        this.setState({ jobs: jobss })

        filteredJobSched.map((jobSched, index) => {
            jobSched.quantity = quantity;
            jobSched.rate_total_cost = jobSched.schedule_rate * quantity;
            const mainIndex = jobSchedule.findIndex(x => (x.id === jobSched.id));
            jobSchedule[mainIndex] = jobSched;
        });

        this.updateDateAndJobCost(job_id,
            (jobs, schedule) => {
                this.setState({ jobSchedule, schedule, jobs }, () => {
                    this.sendToParent();
                });
            });
    }
    toggleCard = index => {
        const jobSchedule = this.state.jobSchedule;
        jobSchedule[index].isRemoved = !jobSchedule[index].isRemoved;

        this.updateDateAndJobCost( jobSchedule[index].job_id,
            (jobs, schedule) => {
                this.setState({ jobSchedule, schedule, jobs }, () => {
                    this.sendToParent()
                });
            });
    }

    scheduleCard = (schedule, job) => {
        const index = this.state.jobSchedule.findIndex(x => (x.job_id === job.id && x.schedule_date === schedule.date));
        const jobSched = this.state.jobSchedule[index];
          
        if(jobSched && jobSched.isRemoved) {
            return (
                <div className='scheduleCardAdd' onMouseOver={() => this.setState({ mouseOverDate: jobSched.schedule_date })}
                    onClick={e => {
                        this.toggleCard(index)
                    }}>
                        <div>
                            <i className="fas fa-plus-circle"></i>
                        </div>
                   
                </div>
            );
        }
        return (
            <div className='scheduleCard' onMouseOver={() => this.setState({ mouseOverDate: jobSched.schedule_date })}>
                <div className='remove' onClick={e => {
                    this.toggleCard(index);
                }}>
                    <i className="fas fa-times"></i>
                </div>
                { jobSched && 
                <>
                    <div className='time'>
                        <div className='time_container'>
                            <TimeSelect selectedTime={jobSched.schedule_from}
                                onChange={newTime => {
                                    this.changeScheduleTime('schedule_from', newTime, index);
                                }}
                            />
                            <TimeSelect selectedTime={jobSched.schedule_to}
                                onChange={newTime => {
                                    this.changeScheduleTime('schedule_to', newTime, index);
                                }}
                            />
                        </div>

                        <div className={`break`}>
                            <table>
                                <tbody>
                                <tr>
                                    <td>Break (mins)</td>
                                    <td>
                                        <input type='number' value={jobSched.schedule_breaktime}
                                            onChange={e => {
                                                this.changeScheduleTime('schedule_breaktime', e.target.value, index);
                                            }}
                                        />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Personnel</td>
                                    <td>
                                        { jobSched.quantity }
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div className='totals'>
                        {jobSched.schedule_workhours} hrs / ${jobSched.schedule_rate.toFixed(2).toLocaleString()}
                    </div>
                    <div className='totals'>
                        ${jobSched.rate_total_cost.toFixed(2).toLocaleString()}
                    </div>
                </>
                }
            </div>
        )
    }

    scheduleBody = () => 
        this.state.jobs && this.state.jobs.map((job, job_index) =>
            <tr key={job_index}>
                { this.state.schedule && this.state.schedule.map( (schedule, sched_index) => 
                    <td key={`${job_index}${sched_index}`}>
                        { this.state.jobSchedule && this.scheduleCard(schedule, job) }
                    </td>
                )}
            </tr>
        )
    
    scheduleTable = () => 
        <div className='scheduleTable'>
            <div className='scheduleTableWrapper' style={{ width: `${this.state.width - 474}px`}}>
                <table ref={this.table} style={{ width: `${200 * this.state.schedule.length}px`}}>
                    <thead>
                        <tr>
                            { this.state.schedule && this.state.schedule.map( (schedule, index) => 
                                <th key={index} className={
                                    `${this.state.mouseOverDate == schedule.date ? 'onHover' : ''}`
                                }>
                                    <p>{ moment(schedule.date).format("ddd, MMM D") }</p>
                                    <p>${ schedule.total_cost }</p>
                                </th>
                            )}
                        </tr>
                    </thead>
                    <tbody>
                        { this.scheduleBody() }
                    </tbody>
                </table>
            </div>
        </div>

    
    jobColumn = () => 
        <div className='jobColumn' style={{ height: this.table.current && this.table.current.offsetHeight}}>
            <div>
                <div className="jobItem jobItemTitle">
                </div>
                { this.state.jobs && this.state.jobs.map((job, index) => 
                    <div className="jobItem" key={index}>
                        <span>{ job.description }</span>
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <span>Rate/hr:</span>
                                </td>
                                <td>
                                    <input type='number' value={job.rate} onChange={e => {
                                        this.changeRate(job.id, parseFloat(e.target.value))
                                    }}/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Personnel:</span>
                                </td>
                                <td>
                                    <input type='number' value={job.quantity} onChange={e => {
                                        this.changeQuantity(job.id, parseFloat(e.target.value))
                                    }}/>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div className="rate">
                            <p>{parseFloat(job.total_hours).toFixed(2).toString()} hrs / ${parseFloat(job.total_cost).toFixed(2).toLocaleString()}</p>
                        </div>
                       
                    </div>
                )}
            </div>
        </div>
        
    render = () => 
    <>
        <div className='scheduling' style={{ width: `${this.state.width - 304}px`, height: this.state.height - 275}}>
            <div>
                <div className='scheduleBody'>
                    { this.jobColumn() }
                    { this.scheduleTable() }
                </div>
            </div>
        </div>

        <div className='buttonContainer'>
            <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                NEXT
            </Button>
        </div>
        </>
}