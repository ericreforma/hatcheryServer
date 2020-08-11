import React, { PureComponent } from 'react';
import moment from 'moment';
import {Row, Col, FormGroup, Label, Input, Button, Modal, ModalHeader, ModalBody, ModalFooter,
        TabContent, TabPane, Nav, NavItem, NavLink,
        UncontrolledButtonDropdown, DropdownMenu, DropdownItem, DropdownToggle } from 'reactstrap';
import { DateRangePicker, SingleDatePicker } from 'react-dates';
import TimeSelect from '../../../elements/TimeSelect';
import 'react-dates/lib/css/_datepicker.css';
import 'react-dates/initialize';
import MultiImagePreview from '../../../components/MultiImagePreview';

import * as Icon from 'react-feather';

export default class Content extends PureComponent{
    constructor(props) {
        super(props);
        
        this.state = {
            name: '',
            description: '',
            image: null,
            days_total: 0,
            hours_total: 0,
            venue: '',
            venue_address: '',
            est_audience: 0,
            nightEvent: false,

            singleDate: null,
            rangeDate_from: null,
            rangeDate_to: null,
            focusedInput: null,
            schedule: [],

            isModalOpen: false,
            dateModal_activeTab: 'single_date',
        }
    }

    componentDidMount() {
        this.setState({
            name: this.props.parentState.content.name || '',
            description: this.props.parentState.content.description || '',
            days_total: this.props.parentState.content.days_total || 0,
            hours_total: this.props.parentState.content.hours_total || 0,
            venue: this.props.parentState.content.venue || '',
            venue_address: this.props.parentState.content.venue_address || '',
            est_audience: this.props.parentState.content.est_audience || 0,
            schedule: this.props.parentState.content.schedule || [],
        });
    }

    breaktimeOptions = () => {
        let options = [];
        for(let x = 0; x <= 60; x += 5){
            options.push(<option key={x}>{x}</option>);
        }

        return options;
    }

    _handleOnChange = (value, input) => {
        this.setState({
            [input]: value
        }, () => {
            this.sendToParent();
        });

    }

    sendToParent = () => {
        this.props.sendStateToParent({
            content: {
                name: this.state.name,
                description: this.state.description,
                days_total: this.state.days_total,
                hours_total: this.state.hours_total,
                venue: this.state.venue,
                venue_address: this.state.venue_address,
                est_audience: this.state.est_audience,
                schedule: this.state.schedule,
            }
        });
    }

    dateModal = () => 
        <Modal 
            isOpen={this.state.isModalOpen} 
            toggle={this._toggleModal} 
            centered
           
        >
            <ModalHeader close={
                <button className="close" onClick={this._toggleModal}>&times;</button>
            }>Pick a date</ModalHeader>
            <ModalBody  className='modal_date'>
                <Nav tabs>

                    <NavItem>
                        <NavLink
                             className={`${this.state.dateModal_activeTab === 'single_date' ? 'active' : ''}`}
                            onClick={() => { this.setState({ dateModal_activeTab: 'single_date' }); }}
                        >
                            Single Date
                        </NavLink>
                    </NavItem>

                    <NavItem>
                        <NavLink
                            className={`${this.state.dateModal_activeTab === 'range_date' ? 'active' : ''}`}
                            onClick={() => { this.setState({ dateModal_activeTab: 'range_date' });  }}
                        >
                            Range Date
                        </NavLink>
                    </NavItem>
                </Nav>
                <TabContent activeTab={this.state.dateModal_activeTab}>
                    <TabPane tabId="single_date">
                        <SingleDatePicker
                            date={this.state.singleDate}
                            onDateChange={date => this.setState({ singleDate: date })}
                            focused={this.state.focused}
                            onFocusChange={({ focused }) => this.setState({ focused })}
                            id="your_unique_id"
                            noBorder={true}
                            showDefaultInputIcon={true}
                            displayFormat="MMMM D, YYYY"
                        />
                    </TabPane>
                    <TabPane tabId="range_date">
                        <DateRangePicker
                            startDate={this.state.rangeDate_from}
                            startDateId="rangeDate_from"
                            endDate={this.state.rangeDate_to}
                            endDateId="rangeDate_to"
                            onDatesChange={({ startDate, endDate }) => 
                                this.setState({ rangeDate_from: startDate, rangeDate_to: endDate 
                            })}
                            focusedInput={this.state.focusedInput}
                            onFocusChange={focusedInput => this.setState({ focusedInput })}
                            noBorder={true}
                            showDefaultInputIcon={true}
                            displayFormat="MMM. D, YYYY"
                        />
                    </TabPane>
                </TabContent>
            </ModalBody>

            <ModalFooter>
                <Button color='primary' size="sm"
                    onClick={() => {
                        this._toggleModal();
                        this.selectDate();
                    }}
                ><Icon.Check />ADD</Button>
            </ModalFooter>

        </Modal>

    _toggleModal = () => {
        const isModalOpen = this.state.isModalOpen;
        this.setState({ isModalOpen: !isModalOpen });
    }

    setDateTime = (datetime, source) => {
        const schedule = this.state.schedule;
        let hours_total = 0;

        schedule.forEach(function(sched, index){
            if(this[index].date ==  moment(datetime).format('YYYY-MM-DD')){
                this[index][source] = datetime;

                const duration = moment.duration(moment(this[index].to).diff(moment(this[index].from)));
                this[index].workhours = parseFloat((duration.asHours() - (this[index].breaktime / 60)).toFixed(2)).toString();
            }
            hours_total += parseFloat(this[index].workhours);
        }, schedule);

        this.setState({ schedule, hours_total: (parseFloat(hours_total).toFixed(2)).toString() },
            () => { this.sendToParent() }
        )
    }

    changeBreakTime = (datetime, breaktime) => {
        const schedule = this.state.schedule;
        let hours_total = 0;

        schedule.forEach(function(sched, index){
            if(this[index].date ==  moment(datetime.date).format('YYYY-MM-DD')){
                const duration = moment.duration(moment(this[index].to).diff(moment(this[index].from)));

                this[index].breaktime = breaktime;
                this[index].workhours = parseFloat((duration.asHours() - (breaktime / 60)).toFixed(2)).toString();
            }
            hours_total += parseFloat(this[index].workhours);
        }, schedule);

        this.setState({ schedule, hours_total: (parseFloat(hours_total).toFixed(2)).toString() },
            () => { this.sendToParent() }
        )
    }

    
  
    removeDate = date => {
        let schedule = this.state.schedule;
        let newSchedule = schedule.filter(d => moment(d.date).format('YYYY-MM-DD') != moment(date).format('YYYY-MM-DD'));
        let hours_total = 0;
        newSchedule.forEach(function(sched, index){
            hours_total += parseFloat(this[index].workhours);
        }, newSchedule)

        this.setState({
            schedule: newSchedule, 
            days_total: newSchedule.length,
            hours_total: (parseFloat(hours_total).toFixed(2)).toString()
        },
            () => { this.sendToParent() }
        )
    }

    setBreakTimeAsDefault = date => {
        let schedule = this.state.schedule;
        let hours_total = 0;

        schedule.forEach(function(sched, index){
            const duration = moment.duration(moment(this[index].to).diff(moment(this[index].from)));

            this[index].breaktime = date.breaktime;
            this[index].workhours = parseFloat((duration.asHours() - (date.breaktime / 60)).toFixed(2)).toString();

            hours_total += parseFloat(this[index].workhours);
        }, schedule);

        this.setState({ schedule, hours_total: (parseFloat(hours_total).toFixed(2)).toString() },
            () => { this.sendToParent() }
        )
    }
    
    setTimeAsDefault = date => {
        let schedule = this.state.schedule;
        let hours_total = 0;

        schedule.forEach(function(sched, index){
            this[index].from = `${moment(this[index].from ).format('YYYY-MM-DD')}T${moment(date.from).format('HH:mm:00')}`;
            this[index].to = `${moment(this[index].to ).format('YYYY-MM-DD')}T${moment(date.to).format('HH:mm:00')}`;

            const duration = moment.duration(moment(this[index].to).diff(moment(this[index].from)));

            this[index].workhours = parseFloat((duration.asHours() - (date.breaktime / 60)).toFixed(2)).toString();
            hours_total += parseFloat(this[index].workhours);
        }, schedule);

        this.setState({ schedule, hours_total: (parseFloat(hours_total).toFixed(2)).toString() },
            () => { this.sendToParent() }
        )
    }

    selectDate = () => {
        let schedule = this.state.schedule;
        let dateSchedule = {};
        let hours_total = this.state.hours_total;

        if(this.state.dateModal_activeTab == 'single_date'){
            dateSchedule.breaktime = 60;
            dateSchedule.workhours = 8;
            dateSchedule.date = moment(this.state.singleDate).format('YYYY-MM-DD');
            dateSchedule.from = moment(this.state.singleDate).format('YYYY-MM-DDT08:00:00');
            dateSchedule.to = moment(this.state.singleDate).format('YYYY-MM-DDT17:00:00');
            hours_total += dateSchedule.workhours;
            schedule.push(dateSchedule);

        } else if(this.state.dateModal_activeTab == 'range_date') {
            for (let m = this.state.rangeDate_from; m.diff(this.state.rangeDate_to, 'days') <= 0; m.add(1, 'days')) {

                if(schedule.filter(e => moment(e.from).format('YYYY-MM-DD') == moment(m).format('YYYY-MM-DD')).length == 0){
                    dateSchedule.breaktime = 60;
                    dateSchedule.workhours = 8;
                    dateSchedule.date = moment(m).format('YYYY-MM-DD');
                    dateSchedule.from = moment(m).format('YYYY-MM-DDT08:00:00');
                    dateSchedule.to = moment(m).format('YYYY-MM-DDT17:00:00');

                    hours_total += dateSchedule.workhours;
                    
                    schedule.push(dateSchedule);
                    dateSchedule = {};
                }
            }
        }

        this.setState({ 
            schedule: schedule.sort(function(a,b){ return new Date(a.date) - new Date(b.date); }), 
            hours_total: (parseFloat(hours_total).toFixed(2)).toString(),
            singleDate: null,
            rangeDate_from: null,
            rangeDate_to: null,
            days_total: schedule.length
        },
            () => { this.sendToParent() }
        )
    }

    schedule = () => 
        this.state.schedule.map((date, index) =>
            <div className='date_item' key={index}>
                <div className='date_value date_column'>
                    { moment(date.from).format('MMM. D, YYYY') }<br/>
                    <span>{ moment(date.from).format('dddd') }</span>
                </div>
                
                <div className='time_value date_column'>

                    <div className='time_row'>
                        <TimeSelect selectedTime={date.from}
                            onChange={newTime => {
                                this.setDateTime(newTime, 'from');
                            }}
                        />
                    </div>

                    <div className='time_row'>
                        <TimeSelect selectedTime={date.to}
                            onChange={newTime => {
                                this.setDateTime(newTime, 'to');
                            }}
                        />
                    </div>

                </div>


                <div className='options_value date_column'>
                    <UncontrolledButtonDropdown size="sm" color='primary' className='option_select'>
                        <DropdownToggle caret>
                            <Icon.ChevronDown />
                        </DropdownToggle>
                        <DropdownMenu>
                            
                            <DropdownItem onClick={e => {
                                this.removeDate(date.from);
                            }}>Remove</DropdownItem>

                            <DropdownItem onClick={() => {
                                this.setTimeAsDefault(date)
                            }}>Set Time As Default</DropdownItem>

                        </DropdownMenu>
                    </UncontrolledButtonDropdown>
                </div>
            </div>    
        )
  
    render = () =>
        <>
            <div className='campaign_details'> 
                <Row>
                    <Col sm='6'>
                        <div className='content_container campaign_create_container'>
                            {/* NAME */}
                                <FormGroup>
                                    <Label>Event Name</Label>
                                
                                    <Input value={this.state.name} type="text" name="name" id="name"
                                        onChange={ e => this._handleOnChange(e.target.value, 'name') } 
                                        invalid={this.props.checkError('name')}
                                    />

                                    { this.props.onError('name') }
                                </FormGroup>

                            {/* DESCRIPTION */}
                                <FormGroup>
                                    <Label>Event / Job Description</Label>
                                
                                    <Input value={this.state.description} type="textarea" name="description" id="description" style={{height: 300}} 
                                        onChange={ e => this._handleOnChange(e.target.value, 'description') } 
                                        invalid={this.props.checkError('description')}
                                    />

                                    { this.props.onError('description') }
                                </FormGroup>

                            {/* VENUE */}
                                <FormGroup>
                                    <Label>Venue</Label>
                                    <Input value={this.state.venue} type="text" name="venue" id="venue"
                                        onChange={ e => this._handleOnChange(e.target.value, 'venue') } 
                                        invalid={this.props.checkError('venue')}
                                    />

                                    { this.props.onError('venue') }
                                </FormGroup>

                            {/* VENUE ADDRESS*/}
                                <FormGroup>
                                    <Label>Venue Address</Label>
                                    <Input value={this.state.venue_address} type="textarea" style={{ height: '150px' }}name="venue_address" id="venue_address"
                                        onChange={ e => this._handleOnChange(e.target.value, 'venue_address') } 
                                        invalid={this.props.checkError('venue_address')}
                                    />

                                    { this.props.onError('venue_address') }
                                </FormGroup>

                            {/* VENUE ADDRESS*/}
                                <FormGroup>
                                    <Label>Estimated Audience</Label>
                                    <Input value={this.state.est_audience} type="number" name="est_audience" id="est_audience"
                                        onChange={ e => this._handleOnChange(e.target.value, 'est_audience') } 
                                        invalid={this.props.checkError('est_audience')}
                                    />

                                    { this.props.onError('est_audience') }
                                </FormGroup>
                        </div>
                    </Col>
                    <Col md='6' className='requirement_wrapper'>
                        <div className='requirement_container campaign_create_container'>
                            { this.dateModal() }

                            <div className='schedule_label'>
                                <Label>Schedule</Label>
                                
                                <div className='schedule_button_container'>
                                    <Button color='primary' size="sm"
                                        onClick={e => { e.preventDefault(); this._toggleModal();  }}
                                        className='add_single_date'
                                    >
                                        Add Date</Button>
                                </div>
                            </div>
                           
                            <div className='schedule_list_container'>
                                <div className='schedule_list_header'>
                                    <div className="date_head thedate_head">Date</div>
                                    <div className="date_head time_head">Time</div>
                                    <div className="date_head option_head"></div>
                                </div>
                                <div className='schedule_list_body'>
                                    { this.state.schedule.length > 0 ? 
                                        this.schedule() 
                                        :
                                        <div className='empty_schedule'>
                                            Click 'Add Date' to start scheduling
                                        </div>
                                    }
                                </div>
                            </div>

                            {/* NEXT BUTTON  */}
                                <FormGroup>
                                    <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                                        NEXT
                                    </Button>
                                    
                                </FormGroup>
                                
                        </div>
                    </Col>
                </Row>
            </div>
        </>
}
