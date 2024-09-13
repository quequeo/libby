import React, { useEffect } from 'react';
import { Box, Typography, Button } from '@mui/material';
import { Link, useNavigate } from 'react-router-dom';
import libbyLogo from '../../assets/libby_logo.png';
import { useAuth } from '../../contexts/AuthContext';

const Welcome = () => {

  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();

  useEffect(() => { if (isAuthenticated) { navigate('/dashboard') }}, [isAuthenticated]);

  return (
    <Box sx={boxStyles}>
      <img src={libbyLogo} alt="Libby Logo" style={logoStyles} />
      <Typography variant="h4" gutterBottom>Welcome to Libby</Typography>
      <Box>
        <Button 
          component={Link} 
          to="/login" 
          variant="contained" 
          color="primary" 
          sx={{ mr: 2, mb: { xs: 2, sm: 0 } }}
        >
          Login
        </Button>
        <Button 
          component={Link} 
          to="/register" 
          variant="outlined" 
          color="primary"
        >
          Create Account
        </Button>
      </Box>
    </Box>
  );
};

export default Welcome;

const boxStyles = {
  display: 'flex',
  flexDirection: 'column',
  justifyContent: 'center',
  alignItems: 'center',
};

const logoStyles = { 
  width: '200px', 
  maxWidth: '100%', 
  height: 'auto', 
  marginBottom: '2rem' 
};