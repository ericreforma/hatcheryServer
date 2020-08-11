import React, { Component } from 'react';
import { Row, Col, Form, Button } from 'reactstrap';
import { HttpForm } from '../../../functions/HttpService';
import URL from '../../../config/url';
import { SOCIALMEDIA} from '../../../config/variables';
import image from '../../../images';

import Content from './Content';
import Costing from './Costing';

import Publish from './Publish';
import { CampaignFunction } from '../../../functions';

export default class EventCreate extends Component {
    constructor(props) {
        super(props);

        this.state = {
            pages: ['Content' ,'Costing', 'Publish'],
            currentPage: 0,
            completedPage: [],
            skillList: [],
            jobList: [],
            content: {
                name: '',
                description: '',
                image: null,
                imagePreview: null,
                venue: '',
                venue_address: '',
                est_audience: 0,
                days_total: 0,
                hours_total: 0,
                schedule: []
            },
            costing: {
                labors: [],
                values: [],
                overallCost: 0
            },

            errorFields: [],
            isPublishing: false
        }

        this._handleChangePage = this._handleChangePage.bind(this);
        this._handleSetState = this._handleSetState.bind(this);
    }

    componentDidMount() {
        CampaignFunction.skills()
        .then(response => {
            this.setState({
                skillList: response.data
            });
        })
        .catch(e => {
            console.log(e);
        });

        CampaignFunction.jobs()
        .then(response => {
            this.setState({
                jobList: response.data
            });
        })
        .catch(e => {
            console.log(e);
        });
    }

    _handleOnChange = (value, input) => {
        this.setState({
            [input]: value
        });
    }

    _handleChangePage = (e, page, source = 'button') => {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            left: 0,
            behavior: 'smooth'
        });  

        let willSwitchPage = true;
        const errorFields = this.doValidation();

        if(errorFields.length > 0){
            this.setState({ errorFields });
            willSwitchPage = false;

            const completedPage = this.state.completedPage;
            if(completedPage.includes(this.state.currentPage)){
                completedPage.filter(i => i != this.state.currentPage);
                this.setState({ completedPage });
            } 
        }

        if(page > this.state.currentPage) {
            for(let i = this.state.currentPage; page < i; i++){
                if(!this.state.completedPage.includes(i)){
                    willSwitchPage = false;
                    break;
                }
            }

        } else if(page < this.state.currentPage) {
            for(let i = page + 1; this.state.currentPage < i; i++){
                if(!this.state.completedPage.includes(i)){
                    willSwitchPage = false;
                    break;
                }
            }
        }
            

        if(willSwitchPage) {
            const completedPage = this.state.completedPage;
            if(!completedPage.includes(this.state.currentPage)){
                completedPage.push(this.state.currentPage);
                this.setState({ completedPage });
            } 
                
            let nextPage = source == 'button' ? this.state.currentPage + page : page;

            (nextPage > -1 && nextPage < 4) && 
                this.setState({
                    errorFields: [],
                    currentPage: nextPage
                });
        }
    }
    
    doValidation = () => {
        const inputForm = this.state[this.state.pages[this.state.currentPage].toLowerCase()];
        let errorFields = [];
        
        if(this.state.currentPage === 0){
           
            for(let key in inputForm){
                (inputForm[key] === null || inputForm[key] === undefined || inputForm[key] === '' ||
                 inputForm[key] == 0 || inputForm[key].length === 0) &&
                    errorFields.push(key)
            }
        }

        console.log(errorFields);
        return errorFields;
    }

    checkError = (inputField, type = 'string') => {
        if(this.state.errorFields.find( (i) =>  i === inputField)) 
            return true;
            
        return false
    }

    onError = (type, message = 'This field is required.') => {
        if(this.checkError(type))
            return <div className='form-error'>{message}</div>;
    }

    _handleSetState = state => { this.setState(state); }

    getPage = () => {

        if(this.state.isPublishing) {
            return (
                <div className='publishing'>
                    <div className='publishing_loader'>
                        <img src={require('../../../images/loading.gif')} />
                        <h5>publishing...</h5>
                    </div>
                </div>
            )
        } else {
            let attr = {
                sendStateToParent: this._handleSetState,
                parentState: this.state,
                errorFields: this.state.errorFields,
                checkError: this.checkError,
                onError: this.onError,
                changePage: this._handleChangePage
            }

            switch(this.state.currentPage) {
                case 0:
                    return <Content {...attr}/>
                case 1:
                    return <Costing  {...attr} skillList={this.state.skillList} jobList={this.state.jobList}/>
                case 2:
                    return <Publish  {...attr} publish={this.publish}/>
            }

        }
    }

    publish = () => {
        this.setState({ isPublishing: true });

        const formData = new FormData();

        formData.append('image', this.state.content.image);
        formData.append('content', JSON.stringify(this.state.content));
        formData.append('costing',JSON.stringify(this.state.costing));

        HttpForm.post(URL.EVENT.PUBLISH, formData)
        .then( (response) => {
            // console.log(response)
            console.log('redirecting');
            this.props.history.push('./list')
        })
        .catch( (e)=> {

            this.setState({ isPublishing: false });
            console.log('error');
            console.log(e.response);
            console.log(e.message);
            console.log(e.request.response);

        })
    }

    smaIcon = () => {
        if(this.state.content.socialMedia !== 0){
            return Object.values(SOCIALMEDIA)[this.state.content.socialMedia - 1].icon
        } else {
            return image.sma_placeholder
        }
    }
    
    render = () => 
        <div className='campaign_create'>
            <Row>
                <Col md={12}>
                    <h3>New Event</h3>
                    <div className='campaign_create_navigation'>
                        <ul>
                            { this.state.pages.map( (page, pageIndex) => 
                                <li 
                                    key={pageIndex} 
                                    className={ 
                                        this.state.currentPage === pageIndex ? 'active' : 
                                        this.state.completedPage.includes(pageIndex) ? 'enabled' : ''
                                    }
                                    onClick={e => {
                                        this._handleChangePage(e, pageIndex, 'tab')
                                    }}
                                >{page}</li>
                            )}
                        </ul>
                    </div>
                    <div className='campaign_create_content'>
                        <Form>
                            <div className='campaign_create_body'>
                                { this.getPage() }
                            </div>
                        </Form>
                        
                      
                        </div>
                    
                </Col>
            </Row>
        </div>
    }