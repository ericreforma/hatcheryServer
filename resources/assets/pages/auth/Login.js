import React, { Component } from 'react';
import { Container, Row, Col, Button, Form, FormGroup, Label, Input, InputGroup } from 'reactstrap';
import { Link } from 'react-router-dom';
import firebase from 'firebase/app';
import { AuthFunction } from '../../functions';
import URL from '../../config/url';



export default class Login extends Component {

	constructor(props) {
		super(props);
		this.state = {
			email:'',
			password:'',
			failed: false,

			fields : [
				'name',
				'businessName',
				'email',
				'contactNumber',
				'password',
				'confirmPassword',
			],

			signup_name: '',
			signup_businessName: '',
			signup_email: '',
			signup_contactNumber: '',
			signup_password: '',
			signup_confirmPassword: '',

			signup_open: false,

			validate_name: false,
			validate_businessName: false,
			validate_email: false,
			validate_contactNumber: false,
			validate_password: false,
			validate_confirmPassword: false,

			errorFields: [],
			firebase_error: '',
			signing_up: false,
			logging_in: false
		}
	}

	login = () => AuthFunction.login(this.state.email, this.state.password, () => {
		this.props.history.push('/');
	}, () => {
		this.setState({ failed: true, logging_in: false });
	});

	// FIREBASE LOGIN
		// login = () => AuthFunction.firebase.login(this.state.email, this.state.password, () => {
		// 	this.props.history.push('/');
		// }, () => {
		// 	this.setState({ failed: true, logging_in: false });
		// });

	// FIREBASE SIGNUP
		// signup = () => {
		// 	this.validate_signup() && AuthFunction.firebase.signup({
		// 		name: this.state.signup_name,
		// 		business_name: this.state.signup_businessName,
		// 		email: this.state.signup_email,
		// 		contact_number: this.state.signup_contactNumber,
		// 		password: this.state.signup_password,
		// 	}, () => {
		// 		this.props.history.push('/');
		// 		this.setState({ signing_up: false })
		// 	}, (e) => {
		// 		this.setState({ 
		// 			firebase_error: e.message,
		// 			signing_up: false 
		// 		});
		// 		this.setState({  })
		// 	})
		// };

	signup = () => {
		this.validate_signup() && AuthFunction.signup(
			this.state.signup_name,
			this.state.signup_businessName,
			this.state.signup_email,
			this.state.signup_contactNumber,
			this.state.signup_password,
		() => {
			this.props.history.push('/');
		});
	};

	validate_email = (email) => {
		let re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(email);
	}

	validate_signup = () => {
		let errorFields = [];
		this.setState({ errorFields });

		this.state.fields.map(field => {
			this.state[`signup_${field}`] === '' &&
                errorFields.push(field)
		});

		if(!this.validate_email(this.state.signup_email) && this.state.signup_email.length > 0) {
			if(errorFields.includes('email') ) {
				const filtered = errorFields.filter(f => f !== 'email');
				errorFields = filtered;
				
			}
			errorFields.push('email_validity');
		}


		if( this.state.signup_password.length < 6 && 
			this.state.signup_password.length > 0){
			
			if(errorFields.includes('password')) {
				const filtered = errorFields.filter(f => f !== 'password');
				errorFields = filtered;
			}

			errorFields.push('password_length')
		}

		if(this.state.signup_password != this.state.signup_confirmPassword){
			errorFields.push('password_not_matched')
		}
		this.setState({ errorFields, signing_up: false })

		if(errorFields.length > 0) return false;
		
		return true;
	}
	
	checkError = field => { 
		if(this.state.errorFields.includes(field))
			return <p className='sign_uperror'>
				{ field === 'password_not_matched' ?
				'Password did not matched!' :
				field === 'password_length' ?
				'Password should be at least 6 characters' :
				field === 'email_validity' ?
				'Invalid email' :
				'This field is required.'
				}
			</p>;
	};

	loginForm = () =>
		<Form>
			<FormGroup>
				<InputGroup>
					<span className="input-group-text"><i className="far fa-envelope"></i></span>
					<Input
						type="email"
						name="email"
						id="email"
						onChange = {(text) => this.setState({ email:text.target.value })}
						value={this.state.email}
						placeholder="Email"
						required
					/>
				</InputGroup>
			</FormGroup>
			<FormGroup>
				<InputGroup>
					<span className="input-group-text"><i className="fas fa-lock"></i></span>
					<Input
						type="password"
						name="password"
						id="password"
						onChange = {(text) => this.setState({password:text.target.value})}
						value={this.state.password}
						placeholder="Password"
						required
					/>
				</InputGroup>
			</FormGroup>
			{ this.state.failed && <span className="error">Invalid email or password.</span>}

			<Button 
				className='button_login' 
				onClick={() => { this.setState({ logging_in: true }); this.login() }}
				disabled={ this.state.logging_in }
			>
				{ this.state.logging_in ? 
					<img src={`${URL.SERVER}/images/rolling.gif`} /> :
					'LOGIN'
				}
			</Button>
			<p className='or'>
				or login with
			</p>
		</Form>


	socialMediaLogin = () => 
		<div className='socialMedia'>
			<Row>
				<Col md={6}>
					<Button className='button_facebook sma_button'
						onClick={ () => {
							console.log('redirecting');
							this.props.history.push('/api/auth/facebook');
							// Firebase Auth
							// AuthFunction.firebase.facebook((user, token) => {
							// 	AuthFunction.login(user, token, () => {
							// 		this.props.history.push('/');
							// 	});
							// });
						}}
					>
						<img src={`${URL.SERVER}/images/facebook_icon.png`}/>
						Facebook
					</Button>
				</Col>
				<Col md={6}>
					<Button className='button_google sma_button'
						onClick={ () => {
							AuthFunction.firebase.google((user, token) => {
								AuthFunction.login(user, token, () => {
									this.props.history.push('/');
								});
							});
						}}
					>
						<img src={`${URL.SERVER}/images/google_icon.png`}/>
						Google
					</Button>
				</Col>
			</Row>
			
			
		</div>
			
	loginFormContainer = () =>
		<>
			{ this.loginForm() }
			{ this.socialMediaLogin() }

			<div className='cta'>
				<span>Not a member?</span>
				<Button color="link" onClick={() => {
					this.setState({ signup_open: true });
				}}>Sigup now</Button>
			</div>
		</>

	signUpForm = () =>
		<div className='signUpForm'>
			<Form>
				<p className='firebase_error'>{ this.state.firebase_error } </p>
				<FormGroup>
					<InputGroup>
						<span className="input-group-text"><i className="fas fa-user"></i></span>
					<Input
						type="text"
						name="signup_name"
						id="signup_name"
						onChange = {(text) => this.setState({signup_name:text.target.value})}
						value={this.state.signup_name}
						placeholder="Full Name"
						required
					/>
					</InputGroup>
					{ this.checkError('name') }

				</FormGroup>
					
				<FormGroup>
					<InputGroup>
						<span className="input-group-text"><i className="fas fa-briefcase"></i></span>
					<Input
						type="text"
						name="signup_businessName"
						id="signup_businessName"
						onChange = {(text) => this.setState({signup_businessName:text.target.value})}
						value={this.state.signup_businessName}
						placeholder="Company / Organization"
						required
					/>
					</InputGroup>
					{ this.checkError('businessName') }
				</FormGroup>
					
				<FormGroup>
					<InputGroup>
						<span className="input-group-text"><i className="fas fa-phone"></i></span>
					<Input
						type="text"
						name="signup_contactNumber"
						id="signup_contactNumber"
						onChange = {(text) => this.setState({signup_contactNumber:text.target.value})}
						value={this.state.signup_contactNumber}
						placeholder="Contact Number"
						required
					/>
					</InputGroup>
					{ this.checkError('contactNumber') }
				</FormGroup>
					
				<FormGroup>
					<InputGroup>
						<span className="input-group-text"><i className="far fa-envelope"></i></span>
					<Input
						type="text"
						name="email"
						id="signup_email"
						onChange = {(text) => this.setState({signup_email:text.target.value})}
						value={this.state.signup_email}
						placeholder="Email"
						required
					/>
					</InputGroup>
					{ this.checkError('email') }
					{ this.checkError('email_validity') }
				</FormGroup>
					
				<FormGroup>
					<InputGroup>
						<span className="input-group-text"><i className="fas fa-lock"></i></span>
					<Input
						type="password"
						name="signup_password"
						id="signup_password"
						onChange = {(text) => this.setState({signup_password:text.target.value})}
						value={this.state.signup_password}
						placeholder="Password"
						required
					/>
					</InputGroup>
					{ this.checkError('password') }
					{ this.checkError('password_length') }
				</FormGroup>
					
				<FormGroup>
					<InputGroup>
						<span className="input-group-text"><i className="fas fa-lock"></i></span>
					<Input
						type="password"
						name="signup_confirmPassword"
						id="signup_confirmPassword"
						onChange = {(text) => this.setState({signup_confirmPassword:text.target.value})}
						value={this.state.signup_confirmPassword}
						placeholder="Confirm Password"
						required
					/>
					</InputGroup>
					{ this.checkError('password_not_matched') }
				</FormGroup>
				<div className='cta'>
					<span>Already a member?</span>
					<Button color="link" onClick={() => {
						this.setState({ signup_open: false });
					}}>Login</Button>
				</div>
			</Form>
			<Button className='button_signup' onClick={() => {this.setState({ signing_up: true }); this.signup()}} 
				disabled={this.state.signing_up}
			>
				{ this.state.signing_up ? 
					<img src={`${URL.SERVER}/images/rolling.gif`} /> :
					'SIGNUP'
				}
				
			</Button>
		</div>

	render = () => (
		<Container className="login d-flex align-items-center justify-content-center">
			<Row>
				<Col className="login-form text-center">
					<div className="login-container">
						<div className="login-image-container"
							style={{backgroundImage: 
								`url(${URL.SERVER}/images/welcome.jpg)`}}>
						
							<div className="login-text-container">
								<h2>WHERE</h2>
								<h1>CREATORS ARE<br/>COLLABORATORS</h1>
								<p>Be part of the platform that connects brands to influencers in a fast and convenient way.</p>
							</div>
						</div>
						<div className="login-form-container">
							<img src={`${URL.SERVER}/images/app-logo.png`} />
							<h3>Hatchery</h3>
							{ this.state.signup_open ?
								this.signUpForm() :
								this.loginFormContainer()
							}
							{  }
						</div>
					</div>
				</Col>
			</Row>
		</Container>
	);
}
