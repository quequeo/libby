import { useState, useEffect } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';
import { Container, Typography, TextField, Button, Box, Alert } from '@mui/material';

function Register() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const { registerUser, isAuthenticated } = useAuth();
  const navigate = useNavigate();
  const [errorMessage, setErrorMessage] = useState('');

  useEffect(() => {
    if (isAuthenticated) {
      navigate('/dashboard');
    }
  }, [isAuthenticated]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      await registerUser({ email, password });
      navigate('/dashboard');
    } catch (error) {
      console.error('Registration failed:', error);
      if (error.response && error.response.data.errors) {
        const errors = error.response.data.errors;

        if (errors.includes('Email has already been taken')) {
          setErrorMessage('Email has already been taken');
        } 
        else if (errors.includes('Email must be a valid email address')) {
          setErrorMessage('Please enter a valid email address.');
        }
        else if (
          errors.includes('Password is too short (minimum is 6 characters)') || 
          errors.includes('Password is too long (maximum is 12 characters)')
        ) {
          setErrorMessage('Password should be between 6 and 12 characters');
        }
      } else {
        setErrorMessage('Something went wrong. Please try again in a few minutes.');
      }
    }
  };

  return (
    <Container component="main" maxWidth="xs">
      <Box sx={boxStyles}>
        {errorMessage && <Alert severity="error">{errorMessage}</Alert>}
        <Typography component="h1" variant="h5">
          Register
        </Typography>
        <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
          <TextField
            margin="normal"
            required
            fullWidth
            id="email"
            label="Email Address"
            name="email"
            autoComplete="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <TextField
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type="password"
            id="password"
            autoComplete="new-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
          >
            Register
          </Button>
        </Box>
      </Box>
    </Container>
  );
}

export default Register;

const boxStyles = {
  marginTop: 8,
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
};