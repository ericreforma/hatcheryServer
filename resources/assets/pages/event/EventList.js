import React, { Component } from 'react';
import moment from 'moment';
import { Row, Col, Badge, ButtonGroup, Button, Pagination, PaginationItem, PaginationLink } from 'reactstrap';
import * as Icon from 'react-feather';
import { Link } from 'react-router-dom';
import { CampaignFunction } from '../../functions/index';
import queryString from 'query-string';
import { CAMPAIGN_TYPE, SOCIALMEDIA } from '../../config/variables';
import image from '../../images';

export default class EventList extends Component {
    constructor(props){
        super(props);

        const page = this.getPageNumber(this.props.location.search);
        this.state = { 
            page,
            paginationData: {},
            listData: [],
            view: 'table',
        }
    }   

    componentDidMount() {
        this.list(this.state.page);
    }

    getPageNumber = (url) => {
        let page = 1;
        
        if(url){
            let query = url.includes('http') ? 
            queryString.parseUrl(url).query : 
            queryString.parse(url);

            page = (Object.entries(query).length === 0 && query.constructor === Object !== null) ? 
            this.state.page : query.page;
        }
        return page;
    }

    list = (page) => {
        CampaignFunction.event.list(page)
        .then(response => {
            this.setState({ 
                page: response.data.current_page,
                listData: response.data.data,
                paginationData: response.data
            });

        })
        .catch( e => {
            console.log(e);
        });
    }

    pagination = () => {
        let pages = [], key = 0;

        pages.push(
            <PaginationItem key={key} disabled={ this.state.paginationData.prev_page_url === null }>
                <PaginationLink previous href={this.state.paginationData.prev_page_url} 
                    onClick={e => { this.switchPage(e, this.getPageNumber(this.state.paginationData.prev_page_url)) }} />
            </PaginationItem>
        );
        
        for(let i = 1; i <= this.state.paginationData.last_page; i++ ){
            key = i;
            pages.push(
                <PaginationItem key={key} active={ this.state.page === i }>
                    <PaginationLink href={`./list?page=${i}`} onClick={e => { this.switchPage(e, i) }}> {i} </PaginationLink>
                </PaginationItem>
            );
        }

        key++;
        pages.push(
            <PaginationItem key={key} disabled={ this.state.paginationData.next_page_url === null }>
                <PaginationLink next href={this.state.paginationData.next_page_url} 
                    onClick={e => { this.switchPage(e, this.getPageNumber(this.state.paginationData.next_page_url)) }}/>
            </PaginationItem>
        );
        return pages;
    }

    switchPage = (e, page) => {
        e.preventDefault();
        this.list(page);
    }

    viewSwitcher = () =>
        <div className='viewSwitcher'>
            <ButtonGroup>
                <Button color={ this.state.view === 'grid' ? 'primary' : 'secondary' } onClick={ () => { this.setState({ view: 'grid' }) } }><Icon.Grid /></Button>
                <Button color={ this.state.view === 'table' ? 'primary' : 'secondary' } onClick={ () => { this.setState({ view: 'table' }) } }> <Icon.List /></Button>
            </ButtonGroup>
        </div>

    tableView = () => 
        <div className='campaign_table_container'>
            <table className='campaign_table'>
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Status</th>
                        <th>Applicants</th>
                        <th>Posting Date</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                {
                
                this.state.listData.length > 0 ?
                this.state.listData.map((li, index) =>
                    <tr key={index}>
                        <td className='table_name'>
                            <div className='campaign_photo' style={{backgroundImage: `url(${URL.SERVER}/storage/${li.media[0].url})`}}>
                            </div>
                            <span>{li.name}</span>
                        </td>
                        <td><Badge color='success'>{li.status}</Badge></td>
                        <td>{li.applicants.length}</td>
                        <td>
                            {(moment(li.created_at).format('MMM. DD, YYYY')).toUpperCase()}<br/>
                            {(moment(li.created_at).format('hh:mm a')).toUpperCase()}
                        </td>
                        <td>
                            <Button size='sm' color='primary' onClick={e => { 
                                e.preventDefault();  
                                this.props.history.push(`./details/${li.id}`)
                            }}>View</Button>
                        </td>
                    </tr>
                ) :
                    <tr>
                        <td colSpan="6">
                            No Records to display
                        </td>
                    </tr>
                }
                </tbody>
            </table>
        </div>

    gridView = () => 
        <div className='gridView'>
            <Row>
                {this.state.listData.map((li, index) => 
                    
                        <Col lg='3' md='4'key={ index }>
                            <Link to={`./details/${li.id}`} >
                            <div className='campaign_card'>
                                <div className='campaign_card_header' style={{ backgroundImage:  `url(../../storage/${li.media.url})`}}>
                                    <div className='campaign_card_social_media'>
                                        <img src={ Object.values(SOCIALMEDIA)[li.social_media].icon_small }/>
                                    </div>
                                </div>
                                <div className='campaign_card_body'>
                                    <h4>{ CAMPAIGN_TYPE[li.type] }</h4>
                                    <h3>{li.name}</h3>
                                    
                                </div>
                                
                            </div>
                            </Link>
                        </Col>
                   
                )}
            </Row>
        </div>

    render = () =>
        <>
            <div className='campaign_list_wrapper'>

                <Button color='primary' onClick={() => this.props.history.push('./create')}>Create New Event</Button>

                { this.viewSwitcher() }

                { this.state.view === 'table' ? this.tableView() : this.gridView() }
                
                <div className='campaign_pagination'>
                    <Pagination>
                        { this.pagination() }
                    </Pagination>
                </div>

            </div>
        </>
    
}
