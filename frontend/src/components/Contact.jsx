import React, { useState } from 'react';
import { Mail, MapPin, Phone } from 'lucide-react';
import './Contact.css';

const Contact = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  });

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Create mailto link with form data
    const mailtoLink = `mailto:patilswara4410@gmail.com?subject=${encodeURIComponent(
      formData.subject
    )}&body=${encodeURIComponent(
      `Name: ${formData.name}\nEmail: ${formData.email}\n\nMessage:\n${formData.message}`
    )}`;
    window.location.href = mailtoLink;
  };

  return (
    <section id="contact" className="contact-section">
      <div className="section-header">
        <h2 className="section-title">Get In Touch</h2>
        <p className="section-description">
          Feel free to reach out for collaborations or just a friendly chat
        </p>
      </div>
      <div className="contact-container">
        <div className="contact-info">
          <div className="contact-info-card card">
            <div className="info-icon">
              <Mail size={28} />
            </div>
            <h3 className="info-title">Email</h3>
            <a href="mailto:patilswara4410@gmail.com" className="info-text">
              patilswara4410@gmail.com
            </a>
          </div>
          <div className="contact-info-card card">
            <div className="info-icon">
              <MapPin size={28} />
            </div>
            <h3 className="info-title">Location</h3>
            <p className="info-text">Pune, Maharashtra, India</p>
          </div>
          <div className="contact-info-card card">
            <div className="info-icon">
              <Phone size={28} />
            </div>
            <h3 className="info-title">Availability</h3>
            <p className="info-text">Open to opportunities</p>
          </div>
        </div>
        <div className="contact-form-wrapper card">
          <h3 className="form-title">Send a Message</h3>
          <form onSubmit={handleSubmit} className="contact-form">
            <div className="form-group">
              <label htmlFor="name">Name</label>
              <input
                type="text"
                id="name"
                name="name"
                value={formData.name}
                onChange={handleChange}
                placeholder="Your name"
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="email">Email</label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                placeholder="your.email@example.com"
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="subject">Subject</label>
              <input
                type="text"
                id="subject"
                name="subject"
                value={formData.subject}
                onChange={handleChange}
                placeholder="Subject of your message"
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="message">Message</label>
              <textarea
                id="message"
                name="message"
                value={formData.message}
                onChange={handleChange}
                placeholder="Your message here..."
                rows="5"
                required
              />
            </div>
            <button type="submit" className="submit-button primary-button">
              Send Message
            </button>
          </form>
        </div>
      </div>
    </section>
  );
};

export default Contact;