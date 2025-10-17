import React from 'react';
import { Code2, Braces, FileJson, Layout, Database, Server } from 'lucide-react';
import './Skills.css';

const Skills = () => {
  const skills = [
    {
      name: 'C++',
      icon: <Code2 size={40} />,
      description: 'Object-oriented programming and data structures',
    },
    {
      name: 'Python',
      icon: <FileJson size={40} />,
      description: 'Web development with Django and AI/ML projects',
    },
    {
      name: 'Java',
      icon: <Braces size={40} />,
      description: 'Core Java programming and problem solving',
    },
    {
      name: 'HTML & CSS',
      icon: <Layout size={40} />,
      description: 'Modern responsive web design and styling',
    },
    {
      name: 'JavaScript',
      icon: <Server size={40} />,
      description: 'Frontend interactivity and DOM manipulation',
    },
    {
      name: 'React JS',
      icon: <Database size={40} />,
      description: 'Building dynamic user interfaces with React',
    },
  ];

  return (
    <section id="skills" className="skills-section">
      <div className="section-header">
        <h2 className="section-title">Technical Skills</h2>
        <p className="section-description">
          Technologies and programming languages I work with
        </p>
      </div>
      <div className="skills-grid">
        {skills.map((skill, index) => (
          <div key={index} className="skill-card card">
            <div className="skill-icon">{skill.icon}</div>
            <h3 className="skill-name">{skill.name}</h3>
            <p className="skill-description">{skill.description}</p>
          </div>
        ))}
      </div>
    </section>
  );
};

export default Skills;