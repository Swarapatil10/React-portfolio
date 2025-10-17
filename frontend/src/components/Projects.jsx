import React from 'react';
import { ExternalLink, Github } from 'lucide-react';
import './Projects.css';

const Projects = () => {
  const projects = [
    {
      name: 'Assignment Monitoring System',
      description: 'A Django web application where teachers can post assignments and students receive real-time email alerts. Features include user authentication, assignment tracking, and automated notifications.',
      technologies: ['Django', 'MySQL', 'Bootstrap', 'SMTP'],
      repo: 'https://github.com/Swarapatil10',
      demo: null,
    },
    {
      name: 'Gesture-Controlled IoT Car',
      description: 'An innovative robotics project that controls a car using hand gestures detected via OpenCV and MediaPipe. The system uses ESP8266 for wireless communication between gesture recognition and car control.',
      technologies: ['Python', 'OpenCV', 'MediaPipe', 'ESP8266'],
      repo: 'https://github.com/Swarapatil10',
      demo: null,
    },
    {
      name: 'Weather Dashboard',
      description: 'A React-based web application that displays real-time weather data with interactive charts and visualizations. Features include location search, weather forecasts, and responsive design.',
      technologies: ['React', 'JavaScript', 'Weather API', 'Chart.js'],
      repo: 'https://github.com/Swarapatil10',
      demo: null,
    },
    {
      name: 'Task Management System',
      description: 'A full-stack CRUD application for managing daily tasks and projects. Features include task creation, editing, deletion, priority levels, and deadline tracking with a clean user interface.',
      technologies: ['React', 'Node.js', 'MongoDB', 'Express'],
      repo: 'https://github.com/Swarapatil10',
      demo: null,
    },
  ];

  return (
    <section id="projects" className="projects-section">
      <div className="section-header">
        <h2 className="section-title">Featured Projects</h2>
        <p className="section-description">
          A showcase of my recent work and personal projects
        </p>
      </div>
      <div className="projects-grid">
        {projects.map((project, index) => (
          <div key={index} className="project-card card">
            <div className="project-header">
              <h3 className="project-name">{project.name}</h3>
            </div>
            <p className="project-description">{project.description}</p>
            <div className="project-tech">
              {project.technologies.map((tech, i) => (
                <span key={i} className="tech-badge">
                  {tech}
                </span>
              ))}
            </div>
            <div className="project-links">
              {project.repo && (
                <a
                  href={project.repo}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="project-link"
                >
                  <Github size={18} />
                  <span>Repository</span>
                </a>
              )}
              {project.demo && (
                <a
                  href={project.demo}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="project-link"
                >
                  <ExternalLink size={18} />
                  <span>Live Demo</span>
                </a>
              )}
            </div>
          </div>
        ))}
      </div>
    </section>
  );
};

export default Projects;