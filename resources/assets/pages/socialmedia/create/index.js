import React, { Component } from 'react';
import { Row, Col, Form, Button, FormFeedback } from 'reactstrap';
import moment from 'moment';
import { HttpForm } from '../../../functions/HttpService';
import URL from '../../../config/url';
import { SOCIALMEDIA} from '../../../config/variables';
import image from '../../../images';
import Content from './Content';
import Budget from './Budget';
import Publish from './Publish';
import Photos from './Photos';
import { CampaignFunction } from '../../../functions';

export default class SocialMediaCreate extends Component {
    constructor(props) {
        super(props);

        this.state = {
            pages: ['Content','Photos', 'Budget', 'Publish'],
            currentPage: 0,
            completedPage: [],
            categoryList: [],
            images: [],
            content: {
                name: '',
                description: '',
                socialMedia: 0,
                hashtag: [],
                mentions: [],
                gender: 0,
                duration: [],
                socialMedia: [],
                followers: '',
                deadline: new Date(),   
                age_from: [18, 65],
                categories: []
            },

            budget: {
                budget: 0,
                collaborator_budget: 0,
                collaborator_count: 0,
                balance: 0,
                basic_pay: 0,
                engagement_budget: 0,
                
                likes_selected: true,
                likes_min: 0,
                likes_max: 0,
                likes_cost: 0,
                likes_per_unit: 0,
                likes_quantity: 0,
                
                comments_selected: false,
                comments_min: 0,
                comments_max: 0,
                comments_cost: 0,
                comments_per_unit: 0,
                comments_quantity: 0,
                
                shares_selected: false,
                shares_min: 0,
                shares_max: 0,
                shares_cost: 0,
                shares_per_unit: 0,
                shares_quantity: 0,
                
                views_selected: false,
                views_min: 0,
                views_max: 0,
                views_cost: 0,
                views_per_unit: 0,
                views_quantity: 0,

            },
            errorFields: [],
            isPublishing: false
        }

        this._handleChangePage = this._handleChangePage.bind(this);
        this._handleSetState = this._handleSetState.bind(this);
    }

    componentDidMount() {
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
        
        if(this.state.currentPage === 2){
            const budget = inputForm;
            const inputSuffix = ['_min','_max','_cost'];
            const engagement_list = ['likes', 'comments','shares','views'];
            const others = ['basic_pay', 'budget', 'collaborator_count'];

            others.map(key => {
                (inputForm[key] === null || inputForm[key] === undefined || inputForm[key] === '' ||
                inputForm[key] == 0 || inputForm[key].length === 0) &&
                   errorFields.push(key)
            });
            
            (inputForm['balance'] !== 0) &&
               errorFields.push('balance')

            // Check for engagement list
            engagement_list.map( (type, index) => {
                if(budget[`${type}_selected`]) {
                    inputSuffix.map( (suffix)=>{
                        (budget[`${type}${suffix}`] === null || budget[`${type}${suffix}`] === undefined || budget[`${type}${suffix}`] === '' ||
                        budget[`${type}${suffix}`] == 0 || budget[`${type}${suffix}`].length === 0) &&
                           errorFields.push(`${type}${suffix}`);
                    });
                }
            });

        } else {
            for(let key in inputForm){
                if(key === 'deadline'){
                    if(moment(inputForm[key]).format('MMM dd, YYYY') ===  moment(new Date).format('MMM dd, YYYY')){
                        errorFields.push(key)
                    }
                }

                (inputForm[key] === null || inputForm[key] === undefined || inputForm[key] === '' ||
                 inputForm[key] == 0 || inputForm[key].length === 0) &&
                    errorFields.push(key)
            }
        }

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
                        <img src={`${URL.SERVER}/images/loading.gif`} />
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
                    return <Content {...attr} categoryList={this.state.categoryList}/>
                case 1:
                    return <Photos  {...attr}/>
                case 2:
                    return <Budget  {...attr}/>
                case 3:
                    return <Publish  {...attr} publish={this.publish}/>
            }

        }
    }

    publish = () => {
        this.setState({ isPublishing: true });

        const formData = new FormData();

        this.state.images.map(img => {
            formData.append("images[]", img);
        })
        formData.append('content', JSON.stringify(this.state.content));
        formData.append('budget',JSON.stringify(this.state.budget));

        HttpForm.post(URL.SOCIALMEDIA.PUBLISH, formData)
        .then( (response) => {
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
        if(this.state.details.socialMedia !== 0){
            return Object.values(SOCIALMEDIA)[this.state.details.socialMedia - 1].icon
        } else {
            return image.sma_placeholder
        }
    }

    render = () => 
        <div className='campaign_create'>
            <Row>
                <Col md={12}>
                    <h3>New Social Media Campaign</h3>
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
                        
                        {/* { !this.state.isPublishing && 
                            <div className='campaign_create_footer'>

                                { (this.state.currentPage) > 0 && 
                                    <Button 
                                    color='info' 
                                    className='campaign_create_footer_button_prev' 
                                    onClick={ e => this._handleChangePage(e, -1)}>Back</Button>
                                }
                                

                                { (this.state.currentPage < 3) && 
                                    <Button 
                                    color='primary' 
                                    className='campaign_create_footer_button_next' 
                                    onClick={ e => this._handleChangePage(e, 1) }>Next</Button>
                                }


                                { (this.state.currentPage === 3) && 
                                    <Button 
                                    color='success' 
                                    className='campaign_create_footer_button_next' 
                                    onClick={ e => this.publish() }>Publish</Button>
                                }
                            </div>
                        } */}
                        </div>
                    
                </Col>
            </Row>
        </div>
        
}
