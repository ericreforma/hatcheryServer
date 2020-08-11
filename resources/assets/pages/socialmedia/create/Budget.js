import React, { Component } from 'react';
import {
    Row,
    Col,
    Label,
    InputGroup,
    Button,
    InputGroupAddon,
    CustomInput,
    FormText,
    FormGroup,
    UncontrolledPopover, PopoverHeader, PopoverBody
} from 'reactstrap';
import NumberFormat from 'react-number-format';
import { ENGAGEMENT } from '../../../config/variables';

export default class Budget extends Component {
    constructor(props) {
        super(props);

        this.state= {
            sm_icons: [
                'far fa-thumbs-up',
                'far fa-comment',
                'fas fa-share',
                'far fa-eye'
            ],
            budget: 0,
            collaborator_budget: 0,
            collaborator_count: 0,
            basic_pay: 0,
            balance: 0,
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
            
        }
    }

    componentDidMount() {
        this.setState({
            budget: this.props.parentState.budget.budget,
            collaborator_count: this.props.parentState.budget.collaborator_count,
            basic_pay: this.props.parentState.budget.basic_pay,
            engagtement_budget: this.props.parentState.budget.engagtement_budget,
            

            likes_min: this.props.parentState.budget.likes_min || 0,
            likes_max: this.props.parentState.budget.likes_max || 0,
            likes_cost: this.props.parentState.budget.likes_cost || 0,
            likes_per_unit: this.props.parentState.budget.likes_per_unit || 0,
            likes_quantity: this.props.parentState.budget.likes_quantity || 0,

            comments_min: this.props.parentState.budget.comments_min || 0,
            comments_max: this.props.parentState.budget.comments_max || 0,
            comments_cost: this.props.parentState.budget.comments_cost || 0,
            comments_per_unit: this.props.parentState.budget.comments_per_unit || 0,
            comments_quantity: this.props.parentState.budget.comments_quantity || 0,

            shares_min: this.props.parentState.budget.shares_min || 0,
            shares_max: this.props.parentState.budget.shares_max || 0,
            shares_cost: this.props.parentState.budget.shares_cost || 0,
            shares_per_unit: this.props.parentState.budget.shares_per_unit || 0,
            shares_quantity: this.props.parentState.budget.shares_quantity || 0,

            views_min: this.props.parentState.budget.views_min || 0,
            views_max: this.props.parentState.budget.views_max || 0,
            views_cost: this.props.parentState.budget.views_cost || 0,
            views_per_unit: this.props.parentState.budget.views_per_unit || 0,
            views_quantity: this.props.parentState.budget.views_quantity || 0,

            likes_selected: this.props.parentState.budget.likes_selected || true,
            comments_selected: this.props.parentState.budget.comments_selected || false,
            shares_selected: this.props.parentState.budget.shares_selected || false,
            views_selected: this.props.parentState.budget.views_selected || false,
        },
            () => {
                ENGAGEMENT.map((type, index) => {
                    this.computeCosts(type.toLowerCase());
                })
            }
        );
    }

    info = () => 
        <>
            <UncontrolledPopover trigger="legacy" placement="right" target="CampaignBudget">
                <PopoverHeader>Campaign Budget</PopoverHeader>
                <PopoverBody>
                    The total budget for this campaign.
                </PopoverBody>
            </UncontrolledPopover>

            <UncontrolledPopover trigger="legacy" placement="right" target="CollaboratorCount">
                <PopoverHeader>Number of collaborator(s)</PopoverHeader>
                <PopoverBody>
                    Total number of influencers you wanted to collaborate with your campaign.
                </PopoverBody>
            </UncontrolledPopover>

            <UncontrolledPopover trigger="legacy" placement="right" target="CollaboratorBudget">
                <PopoverHeader>Budget for each collaborator</PopoverHeader>
                <PopoverBody>
                    The amount of budget allocated for each influencer. This value will be used for engagement costing.
                </PopoverBody>
            </UncontrolledPopover>
            
            <UncontrolledPopover trigger="legacy" placement="right" target="Balance">
                <PopoverHeader>Balance</PopoverHeader>
                <PopoverBody>
                    It will indicate the remaining or excess balance of the total budget that is allocated for the collaborator. The initial value is the total budget allocated for each collaborator. The zero value means that the budget is distributed correctly on each engagement.
                </PopoverBody>
            </UncontrolledPopover>
            <UncontrolledPopover trigger="legacy" placement="right" target={`EngagementMin`}>
                <PopoverHeader>Minimum</PopoverHeader>
                <PopoverBody>
                    The minimum amount of engagement required for the post to accumulate the incentive.
                </PopoverBody>
            </UncontrolledPopover>
            <UncontrolledPopover trigger="legacy" placement="right" target={`EngagementMax`}>
                <PopoverHeader>Maximum</PopoverHeader>
                <PopoverBody>
                    The maximum number of engagement to limit the acquisition of incentive.
                </PopoverBody>
            </UncontrolledPopover>
            <UncontrolledPopover trigger="legacy" placement="right" target={`EngagementQuantity`}>
                <PopoverHeader>Quantity</PopoverHeader>
                <PopoverBody>
                    The total number of engagement that can be converted into incentive. The value is between the minimum and the maximum number of engagement required.
                </PopoverBody>
            </UncontrolledPopover>
            <UncontrolledPopover trigger="legacy" placement="right" target={`EngagementBudget`}>
                <PopoverHeader>Allocated Budget</PopoverHeader>
                <PopoverBody>
                    The total allocated budget for the specific engagement.
                </PopoverBody>
            </UncontrolledPopover>
            <UncontrolledPopover trigger="legacy" placement="right" target={`EngagementPerUnit`}>
                <PopoverHeader>Cost per engagement</PopoverHeader>
                <PopoverBody>
                    The total cost per single unit of engagement.
                </PopoverBody>
            </UncontrolledPopover>
        </>
    
    _handleOnChange = (value, input, type = null, engagement = null) => {
        if(type == 'number') {
            value = this.number(value);
        }

        this.setState({
            [input]: value
        }, () => {
            this.sendToParent();
            this.computeCosts(engagement);
        });
    }

    sendToParent = () => {
        this.props.sendStateToParent({
            budget: {
                budget: this.state.budget || 0,
                collaborator_count: this.state.collaborator_count || 0,
                collaborator_budget: this.state.collaborator_budget || 0,
                balance: this.state.balance || 0,
                basic_pay: this.state.basic_pay || 0,
                engagement_budget: this.state.engagement_budget || 0,

                likes_min: this.state.likes_min || 0,
                likes_max: this.state.likes_max || 0,
                likes_cost: this.state.likes_cost || 0,
                likes_quantity: this.state.likes_quantity || 0,
                likes_per_unit: this.state.likes_per_unit || 0,

                comments_min: this.state.comments_min || 0,
                comments_max: this.state.comments_max || 0,
                comments_cost: this.state.comments_cost || 0,
                comments_quantity: this.state.comments_quantity || 0,
                comments_per_unit: this.state.comments_per_unit || 0,

                shares_min: this.state.shares_min || 0,
                shares_max: this.state.shares_max || 0,
                shares_cost: this.state.shares_cost || 0,
                shares_quantity: this.state.shares_quantity || 0,
                shares_per_unit: this.state.shares_per_unit || 0,

                views_min: this.state.views_min || 0,
                views_max: this.state.views_max || 0,
                views_cost: this.state.views_cost || 0,
                views_quantity: this.state.views_quantity || 0,
                views_per_unit: this.state.views_per_unit || 0,

                likes_selected: this.state.likes_selected || false,
                comments_selected: this.state.comments_selected || false,
                shares_selected: this.state.shares_selected || false,
                views_selected: this.state.views_selected || false,
            }
        });
    }

    number = (num) => parseFloat(num.split(',').join(''));

    computeCosts = (engagement) => {
        let quantity = 0;
        let collaborator_budget = 0;
        let per_unit = 0;
        let balance = 0;

        // BUDGET PER COLLABORATOR
        if( (this.state.collaborator_count != 0 && this.state.budget != 0) || 
            (this.state.collaborator_count != '' && this.state.budget != '')) {
                
            collaborator_budget =  this.state.budget / this.state.collaborator_count;

            ENGAGEMENT.map((type, index) => {
                if (this.state[`${type.toLowerCase()}s_selected`] )
                    balance += (this.state[`${type.toLowerCase()}s_cost`] || 0);
            });
        }

        if(engagement) {
            
            // RANGE DIFFERNCE
            quantity =  this.state[`${engagement}s_max`] - this.state[`${engagement}s_min`];
            per_unit = this.state[`${engagement}s_cost`] / quantity;

            this.setState({
                [`${engagement}s_quantity`]: quantity,
                [`${engagement}s_per_unit`]: isNaN(per_unit) || per_unit === 0 ? 0 : per_unit.toFixed(2),
            });
        }

        this.setState({
            collaborator_budget,
            engagement_budget: collaborator_budget - this.state.basic_pay,
            balance: (collaborator_budget - balance) - this.state.basic_pay
        }, () => {
            this.sendToParent();
        });

    }

    render = () => 
        <div className='campaign_budget'>
            {/* CAMPAIGN BUDGET */}
                <Row>
                    <Col md={6}>
                        <FormGroup>
                            <Row>
                                <Col md={5}>
                                    <Label>Campaign Budget</Label>
                                </Col>
                                <Col md={6}>
                                    <InputGroup>
                                        <InputGroupAddon addonType="prepend">Php</InputGroupAddon>
                                        <NumberFormat name='budget'
                                            className={`form-control number ${this.props.checkError('budget') ? 'is-invalid' : ''}`}
                                            decimalScale={2}
                                            value={this.state.budget} 
                                            thousandSeparator={true}
                                            onChange={ e => { this._handleOnChange(e.target.value, 'budget', 'number') } }
                                        />
                                    </InputGroup>
                                    { this.props.onError('budget') }
                                </Col>
                                <Col md={1}>
                                    <div className="info" >
                                        <i className="fas fa-info-circle info" type="button" id="CampaignBudget"/>
                                    </div>
                                </Col>
                            </Row>
                        </FormGroup>
                    </Col>
                    
                </Row>
            <Row>
                <Col md={12}><hr /></Col>
            </Row>
            
            <Row>
                <Col md={6}>
                    {/* NUMBER OF COLLABORATORS */}
                        <FormGroup>
                            <Row>
                                <Col md={5}>
                                    <Label>Number of collaborator(s)</Label>
                                </Col>
                                <Col md={6}>
                                    <NumberFormat 
                                        name="collaborator_count"
                                        className={`form-control number ${this.props.checkError('collaborator_count') ? 'is-invalid' : ''}`}
                                        value={this.state.collaborator_count} 
                                        decimalScale={2}
                                        thousandSeparator={true}
                                        onChange={ e => { this._handleOnChange(e.target.value, 'collaborator_count', 'number') } }
                                    />
                                    
                                    { this.props.onError('collaborator_count') }
                                </Col>
                                <Col md={1}>
                                    <div className="info" >
                                        <i className="fas fa-info-circle info" type="button" id="CollaboratorCount"/>
                                    </div>
                                </Col>
                            </Row>
                        </FormGroup>
                </Col>
                <Col md={6}>
                    {/* BUDGET FOR COLLABORTOR */}
                        <FormGroup>
                            <Row>
                                <Col md={5}>
                                    <Label>Budget for each collaborator</Label>
                                </Col>
                                <Col md={6}>
                                    <InputGroup>
                                        <InputGroupAddon addonType="prepend">Php</InputGroupAddon>
                                        <NumberFormat 
                                            className='form-control number'
                                            decimalScale={2}
                                            thousandSeparator={true}
                                            value={this.state.collaborator_budget} 
                                            disabled
                                        />
                                    </InputGroup>
                                </Col>
                                <Col md={1}>
                                    <div className="info" >
                                        <i className="fas fa-info-circle info" type="button" id="CollaboratorBudget"/>
                                    </div>
                                </Col>
                            </Row>
                        </FormGroup>
                </Col>
            </Row>
            
            <Row>
                <Col md={6}>
                    {/* BASIC PAY */}
                        <FormGroup>
                            <Row>
                                <Col md={5}>
                                    <Label>Basic Pay</Label>
                                </Col>
                                <Col md={6}>
                                    <InputGroup>
                                        <InputGroupAddon addonType="prepend">Php</InputGroupAddon>
                                        <NumberFormat 
                                            name="basic_pay"
                                            className={`form-control number ${this.props.checkError('basic_pay') ? 'is-invalid' : ''}`}
                                            value={this.state.basic_pay} 
                                            decimalScale={2}
                                            thousandSeparator={true}
                                            onChange={ e => { this._handleOnChange(e.target.value, 'basic_pay', 'number') } }
                                        />
                                        
                                        { this.props.onError('basic_pay') }
                                    </InputGroup>
                                </Col>
                                <Col md={1}>
                                    <div className="info" >
                                        <i className="fas fa-info-circle info" type="button" id="CollaboratorBudget"/>
                                    </div>
                                </Col>
                            </Row>
                        </FormGroup>
                </Col>
                <Col md={6}>
                    {/* BUDGET FOR ENGAGMENT */}
                        <FormGroup>
                            <Row>
                                <Col md={5}>
                                    <Label>Budget for engagment</Label>
                                </Col>
                                <Col md={6}>
                                    <InputGroup>
                                        <InputGroupAddon addonType="prepend">Php</InputGroupAddon>
                                        <NumberFormat 
                                            className='form-control number'
                                            decimalScale={2}
                                            thousandSeparator={true}
                                            value={this.state.engagement_budget} 
                                            disabled
                                        />
                                    </InputGroup>
                                </Col>
                                <Col md={1}>
                                    <div className="info" >
                                        <i className="fas fa-info-circle info" type="button" id="CollaboratorBudget"/>
                                    </div>
                                </Col>
                            </Row>
                        </FormGroup>
                </Col>
            </Row>
            <Row>
                <Col md={12}><hr /></Col>
            </Row>
            <div className='engagementCosting'>

            <FormGroup>
                <Row>
                    <Col md={9}>
                        <h4>Engagement Costing</h4>
                    </Col>
                    <Col md={3}>
                        <div>Balance <i className="fas fa-info-circle info" type="button" id="Balance"/></div>
                        <InputGroup>
                            <InputGroupAddon addonType="prepend">Php</InputGroupAddon>
                            <NumberFormat 
                                className={`form-control number ${(this.number(this.state.balance.toString()) != 0) ? 'is-invalid' : 'is-valid'}`}
                                decimalScale={2}
                                thousandSeparator={true}
                                value={this.state.balance}
                                disabled
                            />
                        </InputGroup>
                    </Col>
                </Row>
            </FormGroup>
            <FormGroup className="costing_header">
                <Row>
                    <Col md='2'>Engagement</Col>
                    <Col md='4'>
                        <Row>
                            <Col md='4'><div>Min <i className="fas fa-info-circle info" type="button" id={`EngagementMin`}/></div></Col>
                            <Col md='4'><div>Max <i className="fas fa-info-circle info" type="button" id={`EngagementMax`}/></div></Col>
                            <Col md='4'><div>Quantity <i className="fas fa-info-circle info" type="button" id={`EngagementQuantity`}/></div></Col>
                        </Row>

                    </Col>
                    <Col md='3'><div>Allocated Budget <i className="fas fa-info-circle info" type="button" id={`EngagementBudget`}/></div></Col>
                    <Col md='3'><div>Cost per Unit <i className="fas fa-info-circle info" type="button" id={`EngagementPerUnit`}/></div></Col>
                </Row>
            </FormGroup>
                { ENGAGEMENT.map((type, index) => 
                    <div className='engagement_costing_container' key={index}>
                        <FormGroup>
                            <Row>
                                {/* SMA ICON */}
                                    <Col md='2'>
                                        <CustomInput type='checkbox' 
                                            id={`exampleCustomCheckbox_${index}`}
                                            className={`form-check-input ${this.state[`${type.toLowerCase()}s_selected`] ? 'selected' : ''}`}
                                            checked={this.state[`${type.toLowerCase()}s_selected`]}
                                            onChange={ e => { this._handleOnChange(e.target.checked, `${type.toLowerCase()}s_selected`) } }
                                            label={<><i className={this.state.sm_icons[index]} />{type}s</>}
                                        />
                                    </Col>

                                {/* RANGE */}
                                    <Col md='4'>
                                        <Row>
                                            <Col md="4">
                                                
                                                <NumberFormat
                                                    className={`form-control number ${this.props.checkError(`${type.toLowerCase()}s_min`) ? 'is-invalid' : ''}`}
                                                    decimalScale={2}
                                                    thousandSeparator={true}
                                                    placeholder="Min" 
                                                    value={this.state[`${type.toLowerCase()}s_min`]} 
                                                    disabled={!this.state[`${type.toLowerCase()}s_selected`]}
                                                    onChange={ e => { this._handleOnChange(e.target.value, `${type.toLowerCase()}s_min`, 'number', type.toLowerCase()); }}
                                                />
                                            </Col>
                                            <Col md="4">
                                                <NumberFormat 
                                                    className={`form-control number ${this.props.checkError(`${type.toLowerCase()}s_max`) ? 'is-invalid' : ''}`}
                                                    decimalScale={2}
                                                    thousandSeparator={true}
                                                    placeholder="Max"
                                                    value={this.state[`${type.toLowerCase()}s_max`]} 
                                                    disabled={!this.state[`${type.toLowerCase()}s_selected`]}
                                                    onChange={ e => { this._handleOnChange(e.target.value, `${type.toLowerCase()}s_max`, 'number', type.toLowerCase()); }}
                                                />
                                            </Col>
                                        
                                            <Col md="4">
                                                
                                                <div className='quantity'>
                                                    {this.state[`${type.toLowerCase()}s_selected`] ?
                                                    this.state[`${type.toLowerCase()}s_quantity`].toLocaleString() : 
                                                    '0'}
                                                </div>
                                                
                                            </Col>
                                        </Row>
                                    </Col>
                                
                            
                                {/* ALLOCATED COST */}
                                    <Col md="3">
                                        
                                        <InputGroup>
                                            <InputGroupAddon addonType="prepend">Php</InputGroupAddon>
                                            <NumberFormat 
                                                className={`form-control number ${this.props.checkError(`${type.toLowerCase()}s_cost`) ? 'is-invalid' : ''}`}
                                                decimalScale={2}
                                                thousandSeparator={true}
                                                value={this.state[`${type.toLowerCase()}s_cost`]}
                                                disabled={!this.state[`${type.toLowerCase()}s_selected`]}
                                                onChange={ e => { this._handleOnChange(e.target.value, `${type.toLowerCase()}s_cost`, 'number', type.toLowerCase()) } }
                                            />
                                        </InputGroup>

                                        
                                    </Col>

                                {/* COST PER UNIT */}
                                    <Col md="3">
                                        <div className='cost_per_unit'>
                                            <div className='unit'>Php</div>
                                            <div className='cost'>
                                                {this.state[`${type.toLowerCase()}s_selected`] ?
                                                this.state[`${type.toLowerCase()}s_per_unit`] : 
                                                '0'} </div>
                                            <div className='per'>/ {type.toLowerCase()}</div>
                                        </div>
                                    </Col>

                            </Row>
                        </FormGroup>
                    </div>
                )}

            </div>
            
           <Row>
                <Col md={8}>
                </Col>
                <Col md={4}>
                    <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                        NEXT
                    </Button>
                </Col>
           </Row>
           
             
           { this.info() }
        </div>
}

