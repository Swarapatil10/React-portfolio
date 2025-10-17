import React from 'react';
import { Music, BookOpen, ChefHat } from 'lucide-react';
import './Hobbies.css';

const Hobbies = () => {
  const hobbiesData = [
    {
      name: 'Classical Dance',
      icon: <Music size={32} />,
      skills: 'Discipline, Creativity, Performance',
    },
    {
      name: 'Reading',
      icon: <BookOpen size={32} />,
      skills: 'Knowledge, Critical Thinking, Focus',
    },
    {
      name: 'Cooking',
      icon: <ChefHat size={32} />,
      skills: 'Creativity, Patience, Experimentation',
    },
  ];

  return (
    <section id="hobbies" className="hobbies-section">
      <div className="section-header">
        <h2 className="section-title">Hobbies & Interests</h2>
        <p className="section-description">
          Activities that inspire and energize me
        </p>
      </div>
      <div className="hobbies-container">
        <div className="hobbies-table-wrapper">
          <table className="hobbies-table">
            <thead>
              <tr>
                <th>Hobby</th>
                <th>Related Skills & Interests</th>
              </tr>
            </thead>
            <tbody>
              {hobbiesData.map((hobby, index) => (
                <tr key={index}>
                  <td>
                    <div className="hobby-cell">
                      <div className="hobby-icon">{hobby.icon}</div>
                      <span>{hobby.name}</span>
                    </div>
                  </td>
                  <td>{hobby.skills}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </section>
  );
};

export default Hobbies;