import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import notFoundImage from '../../assets/not_found.webp';

const NotFound = () => {
  const navigate = useNavigate();

  useEffect(() => {
    setTimeout(() => {
      navigate(-1);
    }, 3000);
  }, [navigate]);

  return (
    <div style={boxStyles}>
      <img src={notFoundImage} alt="Not Found" style={imageStyles} />
      <h1>Ops! Page not found</h1>
      <p>You'll be redirected in 3 seconds. Hold on...</p>
    </div>
  );
};

export default NotFound;

const boxStyles = {
  display: 'flex',
  flexDirection: 'column',
  justifyContent: 'center',
  alignItems: 'center',
  height: '100vh',
};

const imageStyles = { 
  width: '200px', 
  maxWidth: '100%', 
  height: 'auto', 
  marginBottom: '2rem' 
};
