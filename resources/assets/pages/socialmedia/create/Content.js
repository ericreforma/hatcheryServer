import React, { Component } from 'react';
import {
        Row, Col, FormGroup, Label, Input, CustomInput, Button
} from 'reactstrap';
import ReactSlider from 'react-slider'
import DatePicker from 'react-datepicker';
import * as Icon from 'react-feather';
import moment from 'moment';

import { DateRangePicker, SingleDatePicker } from 'react-dates';
import TimeSelect from '../../../elements/TimeSelect';
import 'react-dates/lib/css/_datepicker.css';
import 'react-dates/initialize';

import TagsInput from '../../../elements/TagsInput';
import { SOCIALMEDIA} from '../../../config/variables';
import { GENDER } from '../../../config/variables';
import CategoryInput from '../../../elements/CategoryInput';
import { CampaignFunction } from '../../../functions';


export default class Content extends Component{
    constructor(props) {
        super(props);
        
        this.state = {
            name: '',
            description: '',
            hashtag: [],
            mentions: [],
            socialMedia: [],
            imageError: "",
            gender: 3,
            followers: '',
            deadline: new Date(),   
            age_range: [18, 65],
            categories: [],
            categoryList: null,
            duration: [null, null],
            focusedInput: null,
        }
    }

    componentDidMount() {
        this.setState({
            name: this.props.parentState.content.name || '',
            socialMedia: this.props.parentState.content.socialMedia || [],
            description: this.props.parentState.content.description || '',
            hashtag: this.props.parentState.content.hashtag || [],
            mentions: this.props.parentState.content.mentions || [],
            gender: this.props.parentState.content.gender || 3,
            categories: this.props.parentState.content.categories || [],
            followers: this.props.parentState.content.followers || '',
            deadline: this.props.parentState.content.deadline || new Date(),
            age_range: this.props.parentState.content.age_range || [18, 65],
        });

        CampaignFunction.categories()
        .then(response => {
            this.setState({
                categoryList: response.data
            });
        })
        .catch(e => {
            console.log(e);
        });
    }

    _handleImageChange = (e) => {
        e.preventDefault();

        let reader = new FileReader();
        let file = e.target.files[0];

        if(file !== undefined){
            reader.onloadend = () => {
                this.setState({
                    image: file,
                    imagePreview: reader.result
                }, () => {
                    this.sendToParent();
                })
            }

            reader.readAsDataURL(file);
        }
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
                socialMedia: this.state.socialMedia,
                description: this.state.description,
                hashtag: this.state.hashtag,
                mentions: this.state.mentions,
                categories: this.state.categories,
                gender: this.state.gender,
                followers: this.state.followers,
                deadline: this.state.deadline,
                age_range: this.state.age_range,
                duration: this.state.duration
            }
        });
    }

    render = () => 
        <>  
            
            <div className='campaign_details'> 
                <Row>
                    <Col md='7'>
                        <div className='content_container campaign_create_container'>
                            <FormGroup>
                                <Label className='form-label'>Campaign Name</Label>

                                <Input value={this.state.name} type="text" name="name" id="name"
                                    onChange={ e => this._handleOnChange(e.target.value, 'name') } 
                                    invalid={this.props.checkError('name')}
                                />

                                { this.props.onError('name') }
                            </FormGroup>
                            
                            <FormGroup>
                                <Label className='form-label'>Description</Label>
                                <Input value={this.state.description} type="textarea" name="description" id="description" style={{height: 300}} 
                                    onChange={ e => this._handleOnChange(e.target.value, 'description') } 
                                    invalid={this.props.checkError('description')}
                                />

                                { this.props.onError('description') }
                            </FormGroup>

                            <FormGroup>
                                <Label className='form-label'>Hash Tag</Label>
                                <TagsInput 
                                    tags={this.props.parentState.content.hashtag}
                                    className={`hashtag_taginput ${this.props.checkError('hashtag') ? 'is-invalid' : ''}`} 
                                    char={'#'}
                                    onChange={ tag => { 
                                        this._handleOnChange(tag, 'hashtag');
                                    }}
                                />
                                { this.props.onError('hashtag') }
                            </FormGroup>

                            <FormGroup>
                            
                                <Label className='form-label'>Mentions</Label>
                                <TagsInput 
                                    tags={this.props.parentState.content.mentions}
                                    className={`mention_taginput ${this.props.checkError('mentions') ? 'is-invalid' : ''}`} 
                                    onChange={ tag => { 
                                        this._handleOnChange(tag, 'mentions');
                                    }}
                                    char={'@'}
                                />
                                { this.props.onError('mentions') }
                            </FormGroup>
                        </div>
                    </Col>
                    <Col md='5' className='requirement_wrapper'>
                        <div className='requirement_container campaign_create_container'>
                            {/* NEXT BUTTOn  */}
                                <FormGroup>
                                    <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                                        NEXT
                                    </Button>
                                    
                                </FormGroup>
                                <hr />

                             {/* DURATION */}
                             <FormGroup>
                                    <Label className='form-label'>Duration</Label>
                                    
                                    <div className='daterangepicker-group'>
                                        <DateRangePicker
                                            startDate={this.state.duration[0]}
                                            startDateId="rangeDate_from"
                                            endDate={this.state.duration[1]}
                                            endDateId="rangeDate_to"
                                            onDatesChange={({ startDate, endDate }) => {
                                                let duration = this.state.duration;
                                                duration[0] = startDate;
                                                duration[1] = endDate;

                                                this._handleOnChange(duration, 'duration');

                                            }}
                                            focusedInput={this.state.focusedInput}
                                            onFocusChange={focusedInput => this.setState({ focusedInput })}
                                            noBorder={true}
                                            showDefaultInputIcon={true}
                                            displayFormat="MMM. D, YYYY"
                                        />
                                    </div>

                                    { this.props.onError('duration','Select a valid date') }
                                </FormGroup>  
                                
                            {/* SOCIAL MEDIA  */}
                                <FormGroup>
                                    <Label className='form-label'>Social Media</Label>

                                    <CategoryInput
                                        categoryList={Object.values(SOCIALMEDIA)} 
                                        categories={this.props.parentState.content.socialMedia}
                                        placeholder='Click to select social media'
                                        type='social_media'
                                        onChange={categories => {
                                            this._handleOnChange(categories, 'socialMedia');
                                    }}/>

                                    { this.props.onError('socialMedia') }
                                
                                    
                                </FormGroup>
                            {/* GENDER */}
                                <FormGroup>
                                    <div className='gender_form_group'>

                                        <Label className='form-label'>Gender</Label>
                                    
                                        <div className='gender-group'>
                                            { GENDER.map((type, index) => 
                                                <CustomInput 
                                                    type='radio'
                                                    id={`gender_check_box_${index}`}
                                                    key={index} 
                                                    onChange={() => this._handleOnChange(index + 1, 'gender')}
                                                    label={type}
                                                    name='gender'
                                                    checked={(this.state.gender == (index + 1))}
                                                >
                                                </CustomInput>
                                            )}
                                        </div>
                                        
                                    </div>

                                </FormGroup>

                            {/* FOLLOWERS */}
                                <FormGroup>
                                    <Label className='form-label'>Followers / Subscribers</Label>
                                
                                    <Input type="number" name="followers" id="followers" value={this.state.followers} 
                                        onChange={ e => { this._handleOnChange(e.target.value, 'followers') } }
                                        invalid={this.props.checkError('followers')}
                                    />
                                    { this.props.onError('followers') }
                                </FormGroup>                    
                            

                            {/* CATEGORIES */}
                                <FormGroup>
                                    <Label className='form-label'>Categories</Label>

                                    { this.state.categoryList && 
                                        <CategoryInput 
                                            categoryList={this.state.categoryList} 
                                            type="influencer"
                                            placeholder='Click to add categories'
                                            categories={this.props.parentState.content.categories} 
                                            onChange={categories => {
                                                this._handleOnChange(categories, 'categories');
                                            }}/>
                                    }

                                    { this.props.onError('categories') }
                                </FormGroup>
                            {/* AGE RANGE */}
                                <FormGroup>
                                    <Label className='form-label'>Age Range</Label>
                                    <Row>
                                        <Col md="12">
                                            <div className='age_range_container'>
                                                <ReactSlider
                                                    min={16}
                                                    max={100}
                                                    className="range-slider"
                                                    thumbClassName="slider-thumb"
                                                    trackClassName="slider-track"
                                                    defaultValue={[16, 65]}
                                                    ariaLabel={['Lower thumb', 'Upper thumb']}
                                                    ariaValuetext={state => `Thumb value ${state.valueNow}`}
                                                    renderThumb={(props, state) => 
                                                        <div {...props}>
                                                            <div>
                                                                <div className='slider-tooltip'>
                                                                    {state.valueNow}
                                                                </div>
                                                                <div className="dot">

                                                                </div>
                                                            </div>
                                                        </div>}
                                                    pearling
                                                    minDistance={10}
                                                    value={this.state.age_range}
                                                    onChange={e => { this._handleOnChange(e, 'age_range') }}
                                                />
                                            </div>
                                        </Col>
                                    </Row>
                                </FormGroup>
                            {/* DEADLINE */}
                                <FormGroup>
                                    <Label className='form-label'>Deadline of Submission</Label>
                                    
                                    <div className='datepicker-group'>
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
                                        <div className='icon'><Icon.Calendar /></div>
                                    </div>

                                    { this.props.onError('deadline','Select a valid date') }
                                </FormGroup>
                            
                            
                        </div>
                    </Col>
                </Row>
            </div>
        
        </>
}
