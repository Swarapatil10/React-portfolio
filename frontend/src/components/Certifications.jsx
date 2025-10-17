import React from 'react';
import { Award, ExternalLink } from 'lucide-react';
import './Certifications.css';

const Certifications = () => {
  const certifications = [
    {
      name: 'Blockchain Technology',
      issuer: 'Industry Certification',
      link: 'https://drive.google.com/file/d/1sL7_ACUjW_fpYnCVeLd2ywOF48t-fChY/view?usp=drivesdk',
    },
    {
      name: 'Smart Contracts',
      issuer: 'Industry Certification',
      link: 'https://drive.google.com/file/d/1ZGJfy_okELA3PZrertCoGeDloa_qsQmH/view?usp=drivesdk',
    },
  ];

  return (
    <section id="certifications" className="certifications-section">
      <div className="section-header">
        <h2 className="section-title">Certifications</h2>
        <p className="section-description">
          Professional certifications and achievements
        </p>
      </div>
      <div className="certifications-grid">
        {certifications.map((cert, index) => (
          <div key={index} className="certification-card card">
            <div className="cert-icon-wrapper">
              <Award size={40} className="cert-icon" />
            </div>
            <div className="cert-content">
              <h3 className="cert-name">{cert.name}</h3>
              <p className="cert-issuer">{cert.issuer}</p>
              <a
                href={cert.link}
                target="_blank"
                rel="noopener noreferrer"
                className="cert-link"
              >
                <span>View Certificate</span>
                <ExternalLink size={16} />
              </a>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
};

export default Certifications;