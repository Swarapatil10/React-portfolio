import React from 'react';
import { GraduationCap } from 'lucide-react';
import './Education.css';

const Education = () => {
  const educationData = [
    {
      degree: 'B.Tech in Computer Science Engineering',
      institution: 'Pimpri Chinchwad University',
      result: '7.85 CGPA',
      period: '2021 - 2025',
    },
    {
      degree: 'Higher Secondary Education (HSC)',
      institution: 'Pratibha Junior College',
      result: '70%',
      period: '2019 - 2021',
    },
    {
      degree: 'Secondary Education (SSC)',
      institution: 'Vidya Niketan English Medium School',
      result: '75%',
      period: '2018 - 2019',
    },
  ];

  return (
    <section id="education" className="education-section">
      <div className="section-header">
        <h2 className="section-title">Education</h2>
        <p className="section-description">
          My academic journey and qualifications
        </p>
      </div>
      <div className="education-container">
        <div className="education-table-wrapper">
          <table className="education-table">
            <thead>
              <tr>
                <th>Degree / Qualification</th>
                <th>Institution</th>
                <th>Result</th>
                <th>Period</th>
              </tr>
            </thead>
            <tbody>
              {educationData.map((edu, index) => (
                <tr key={index}>
                  <td>
                    <div className="degree-cell">
                      <GraduationCap size={20} className="degree-icon" />
                      <span>{edu.degree}</span>
                    </div>
                  </td>
                  <td>{edu.institution}</td>
                  <td>
                    <span className="result-badge">{edu.result}</span>
                  </td>
                  <td>{edu.period}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </section>
  );
};

export default Education;