import React, { Component } from 'react';
import { Card, CardBody, Row, Col } from 'reactstrap';

class PrivacyPolicy extends Component {
  render() {
    const heroStyles = {
        padding: '50px 0 70px',

      };
    return (
      <div>
        <Row>
            <Col md={3}></Col>
          <Col md={6}>
            <div className="home-hero" style={heroStyles}>
                <h2>HATCHERY</h2>
                <h1>Privacy Policy</h1>
                <p className="text-muted">
                    The HATCHERY recognizes the importance of privacy and are committed to maintaining the accuracy, confidentiality and security of your personal information. HATCHERY maintains physical, electronic and procedural safeguards that are appropriate to the sensitivity of your personal information. These safeguards are designed to protect your personal information from loss and unauthorized access, modification or disclosure. Unless you advise us otherwise, by receiving this Privacy Policy, you are deemed to have given your consent to the collection and use of your personal information to update you on our work, present you with opportunities to support, and provide you with opportunities to feed back to us through surveys.
                    <br/>
                    <br/>
                    HATCHERY may use the personal information you provide to contact you in response to a query or suggestion, send you updates and other promotional information, confirm any donation or registration made through the donation page, obtain payment for purchases made through the donation page, or undertake statistical analysis. You can cancel or modify your information at any time by e-mailing recruitment@liberal.ph.
                    <br/>
                    <br/>
                    By submitting the application, you declare that the information you provided is freely given, true, complete, and accurate, and acknowledge that the HATCHERY may verify the information from sources accessible under the law.
                </p>
            </div>
          </Col>
          <Col md={3}></Col>
        </Row>
      </div>
    );
  }
}

export default PrivacyPolicy;
