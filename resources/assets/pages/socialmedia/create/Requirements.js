import React, { Component } from 'react';
import DatePicker from 'react-datepicker';
import { Row, Col, FormGroup, Label, Input, Button, ButtonGroup } from 'reactstrap';
import { GENDER } from '../../../config/variables';
import CategoryInput from '../../../elements/CategoryInput';
import * as Icon from 'react-feather';

export default class Requirements extends Component {
    constructor(props) {
        super(props);
        this.state = {
            gender: 4,
            followers: '',
            deadline: new Date(),   
            age_from: '',
            age_to: '',
            categories: []
        }
    }

    componentDidMount() {
        this.setState({
            gender: this.props.parentState.requirements.gender || 4,
            categories: this.props.parentState.requirements.categories || [],
            followers: this.props.parentState.requirements.followers || '',
            deadline: this.props.parentState.requirements.deadline || new Date(),
            age_from: this.props.parentState.requirements.age_from || '',
            age_to: this.props.parentState.requirements.age_to || '',
        });
        
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
            requirements: {
                categories: this.state.categories,
                gender: this.state.gender,
                followers: this.state.followers,
                deadline: this.state.deadline,
                age_from: this.state.age_from,
                age_to: this.state.age_to,
            }
        });
    }

    render = () => 
        <div className='campaign_requirements'>
            
            <FormGroup>
                <Row>
                    <Col md={2}>
                        <Label>Gender</Label>
                    </Col>
                    <Col md={5}>
                        <ButtonGroup>
                            { GENDER.map((type, index) => 
                                <Button 
                                    color={`${this.state.gender === (index + 1) ? 'primary' : 'secondary'}`} 
                                    key={index} 
                                    onClick={() => this._handleOnChange(index + 1, 'gender')}>
                                    {type}
                                </Button>
                            )}
                        </ButtonGroup>
                        { this.props.checkError('gender') }
                    </Col>
                </Row>
            </FormGroup>
            <FormGroup>
                <Row>
                    <Col md={2}>
                        <Label>Followers / Subscribers</Label>
                    </Col>
                    <Col md={5}>
                        <Input type="number" name="followers" id="followers" value={this.state.followers} 
                            onChange={ e => { this._handleOnChange(e.target.value, 'followers') } }
                            invalid={this.props.checkError('followers')}
                        />
                        { this.props.onError('followers') }
                    </Col>
                </Row>
            </FormGroup>
            <FormGroup>
                <Row>
                    <Col md={2}>
                        <Label>Categories</Label>
                    </Col>
                    <Col md={5}>
                        <CategoryInput categoryList={this.props.categoryList} categories={this.props.parentState.requirements.categories} 
                        onChange={categories => {
                            this._handleOnChange(categories, 'categories');
                        }}/>

                        { this.props.onError('categories') }
                    </Col>
                </Row>
            </FormGroup>
            <FormGroup>
                <Row>
                    <Col md={2}>
                        <Label>Age Range</Label>
                    </Col>
                    <Col md={5}>
                        <Row>
                            <Col md="6">
                                <Input type="number" name="age_from" id="age_from" min="18" max="60" 
                                    placeholder="From" value={this.state.age_from} 
                                    onChange={ e => { this._handleOnChange(e.target.value, 'age_from') } }
                                    invalid={this.props.checkError('age_from')}
                                />
                                { this.props.onError('age_from') }
                            </Col>
                            <Col md="6">
                                <Input type="number" name="age_to" id="age_to" min="18" max="60" 
                                    placeholder="To" value={this.state.age_to} 
                                    onChange={ e => { this._handleOnChange(e.target.value, 'age_to') } }
                                    invalid={this.props.checkError('age_to')}
                                />
                                { this.props.onError('age_to') }
                            </Col>
                        </Row>
                    </Col>
                </Row>
            </FormGroup>
            <FormGroup>
                <Row>
                    <Col md={2}>
                        <Label>Deadline of Submission</Label>
                    </Col>
                    <Col md={5} className="calendar">
                        <DatePicker
                            filterDate={date => (new Date() < date)}
                            selected={ this.state.deadline }
                            onChange={date => { this._handleOnChange(date, 'deadline') }}
                            showTimeSelect
                            timeFormat="h:mm aa"
                            timeIntervals={15}
                            timeCaption="time"
                            dateFormat="MMMM d, yyyy h:mm aa"
                            className='form-control'
                            showMonthDropdown
                            showYearDropdown
                            dropdownMode="select"
                        />
                        
                           <Icon.Calendar />

                        { this.props.onError('deadline') }
                    </Col>
                </Row>
            </FormGroup>
        </div>
}
