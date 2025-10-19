import React from 'react';
import { ArrowRight, Github, Linkedin, Mail } from 'lucide-react';
import './Home.css';

const Home = () => {
  const handleScrollToContact = (e) => {
    e.preventDefault();
    const element = document.querySelector('#contact');
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <section id="home" className="home-section">
      <div className="home-content">
        <div className="home-text">
          <h1 className="home-title">
            Hi, I'm <span className="highlight">Swara Patil</span>
          </h1>
          <p className="home-subtitle">Computer Science Engineering Student</p>
          <p className="home-description">
            A curious and passionate web developer with experience in C++, HTML, CSS, 
            and learning Django & AI. I love building creative, real-world projects and 
            participating in hackathons to push my limits. I enjoy solving problems, 
            designing interfaces, and writing clean code.
          </p>
          <div className="home-buttons">
            <button className="primary-button" onClick={handleScrollToContact}>
              Get In Touch <ArrowRight size={18} />
            </button>
            <a href="#projects" className="secondary-button">
              View Projects
            </a>
          </div>
          <div className="social-links">
            <a 
              href="https://github.com/Swarapatil10?tab=repositories" 
              target="_blank" 
              rel="noopener noreferrer"
              className="social-link"
              aria-label="GitHub"
            >
              <Github size={24} />
            </a>
            <a 
              href="https://www.linkedin.com/in/swara-patil10/" 
              target="_blank" 
              rel="noopener noreferrer"
              className="social-link"
              aria-label="LinkedIn"
            >
              <Linkedin size={24} />
            </a>
            <a 
              href="mailto:patilswara4410@gmail.com"
              className="social-link"
              aria-label="Email"
            >
              <Mail size={24} />
            </a>
          </div>
        </div>
        <div className="home-image">
          <div className="image-container">
            <img 
              src="/profile-photo.jpg" 
              alt="Swara Patil" 
              className="profile-photo"
            />
          </div>
        </div>
      </div>
    </section>
  );
};

export default Home;