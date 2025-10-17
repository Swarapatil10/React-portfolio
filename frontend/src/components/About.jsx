import React from 'react';
import { Mail, User, Briefcase, Heart } from 'lucide-react';
import './About.css';

const About = () => {
  const handleEmailClick = () => {
    window.location.href = 'mailto:patilswara4410@gmail.com';
  };

  return (
    <section id="about" className="about-section">
      <div className="section-header">
        <h2 className="section-title">About Me</h2>
        <p className="section-description">
          Get to know more about my background and passion
        </p>
      </div>
      <div className="about-content">
        <div className="about-grid">
          <div className="about-card card">
            <div className="about-icon">
              <User size={32} />
            </div>
            <h3 className="about-card-title">Who I Am</h3>
            <p className="about-card-text">
              I'm Swara Patil, a Computer Science Engineering student at Pimpri Chinchwad University 
              with a passion for web development and emerging technologies.
            </p>
          </div>
          <div className="about-card card">
            <div className="about-icon">
              <Briefcase size={32} />
            </div>
            <h3 className="about-card-title">What I Do</h3>
            <p className="about-card-text">
              I specialize in building web applications using modern technologies like React, Django, 
              and exploring AI/ML. I love participating in hackathons and solving real-world problems.
            </p>
          </div>
          <div className="about-card card">
            <div className="about-icon">
              <Heart size={32} />
            </div>
            <h3 className="about-card-title">What Drives Me</h3>
            <p className="about-card-text">
              I'm driven by curiosity and the desire to create impactful solutions. I enjoy learning 
              new technologies, designing intuitive interfaces, and writing clean, efficient code.
            </p>
          </div>
        </div>
        <div className="about-summary card">
          <h3 className="summary-title">Professional Summary</h3>
          <p className="summary-text">
            Hello! I'm Swara Patil, a Computer Science Engineering student at Pimpri Chinchwad University. 
            I'm a curious and passionate web developer with experience in C++, HTML, CSS, and learning 
            Django & AI. I love building creative, real-world projects and participating in hackathons 
            to push my limits. I enjoy solving problems, designing interfaces, and writing clean code. 
            Let's build something amazing together!
          </p>
          <button className="message-button primary-button" onClick={handleEmailClick}>
            <Mail size={20} />
            Send Me a Message
          </button>
        </div>
      </div>
    </section>
  );
};

export default About;