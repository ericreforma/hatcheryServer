import React, { Component } from 'react';
import moment from 'moment';
import {Row, Col, FormGroup, Label, Input, Button, Modal, ModalHeader, ModalBody, ModalFooter,
        TabContent, TabPane, Nav, NavItem, NavLink,
        UncontrolledButtonDropdown, DropdownMenu, DropdownItem, DropdownToggle } from 'reactstrap';

import * as Icon from 'react-feather';

export default class Photos extends Component{
    constructor(props) {
        super(props);
        
        this.state = {
           images: []
        }
    }

    componentDidMount() {
        this.setState({
            images: this.props.parentState.images || null,
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
            images: this.state.images,
        });
    }
  
    _handleMultipleImage = e => {
        if (e.target.files) {
            const files = Array.from(e.target.files);

            const images = this.state.images;
            const newImages = [...images, ...files];

            this.setState({ images: newImages }, () => {
                this.sendToParent();
            });
        }
    }
    removeImage = image => {
        const filteredImage = this.state.images.filter(x => x != image);
        this.setState({ images: filteredImage }, () => {
            this.sendToParent();
        });
    }

    render = () =>
        <>
            <div className='campaign_details'> 
                <Row>
                    <Col sm='12'>
                        <div className='content_container campaign_create_container'>
                            <FormGroup>
                                <Input 
                                    type='file'
                                    name='image'
                                    id='image'
                                    accept='image/*'
                                    multiple
                                    onChange={ e => this._handleMultipleImage(e) }
                                    invalid={this.props.checkError('images')}
                                />

                                <Label for='image' className='image_upload_label'>  
                                    Select photos
                                </Label>
                                <div className='image_upload_container'>
                                    { this.state.images && this.state.images.map((img, index) => 
                                        <div key={index} onClick={e => this.removeImage(img)}>
                                            <div className='close_container'>
                                                <i className="fas fa-times-circle"></i>
                                            </div>

                                            <img src={window.webkitURL.createObjectURL(img)} />
                                        </div>
                                    )}
                                </div>
                            </FormGroup>
                            <Row>
                                <Col sm='8'></Col>
                                <Col sm='4'>
                                    <FormGroup>
                                        <Button block color="primary" onClick={ e => this.props.changePage(e, 1) } >
                                            NEXT
                                        </Button>
                                    </FormGroup>
                                </Col>
                            </Row>
                        </div>
                    </Col>
                </Row>
                
            </div>
        </>
}
