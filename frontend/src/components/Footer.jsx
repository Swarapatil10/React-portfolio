import React from 'react';
import { Github, Linkedin, Mail, Heart } from 'lucide-react';
import './Footer.css';

const Footer = () => {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="footer">
      <div className="footer-content">
        <div className="footer-top">
          <div className="footer-brand">
            <h3 className="footer-logo">Swara Patil</h3>
            <p className="footer-tagline">
              Building innovative solutions with passion and creativity
            </p>
          </div>
          <div className="footer-links">
            <div className="footer-column">
              <h4 className="footer-heading">Quick Links</h4>
              <ul className="footer-list">
                <li><a href="#home">Home</a></li>
                <li><a href="#skills">Skills</a></li>
                <li><a href="#projects">Projects</a></li>
                <li><a href="#education">Education</a></li>
              </ul>
            </div>
            <div className="footer-column">
              <h4 className="footer-heading">More</h4>
              <ul className="footer-list">
                <li><a href="#certifications">Certifications</a></li>
                <li><a href="#hobbies">Hobbies</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
              </ul>
            </div>
            <div className="footer-column">
              <h4 className="footer-heading">Connect</h4>
              <div className="footer-social">
                <a
                  href="https://github.com/Swarapatil10?tab=repositories"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="footer-social-link"
                  aria-label="GitHub"
                >
                  <Github size={20} />
                </a>
                <a
                  href="https://www.linkedin.com/in/swara-patil10/"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="footer-social-link"
                  aria-label="LinkedIn"
                >
                  <Linkedin size={20} />
                </a>
                <a
                  href="mailto:patilswara4410@gmail.com"
                  className="footer-social-link"
                  aria-label="Email"
                >
                  <Mail size={20} />
                </a>
              </div>
            </div>
          </div>
        </div>
        <div className="footer-bottom">
          <p className="footer-copyright">
            © {currentYear} Swara Patil. Made with <Heart size={16} className="heart-icon" /> 
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
