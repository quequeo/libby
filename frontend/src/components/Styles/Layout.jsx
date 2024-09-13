import React from 'react';
import { Box, Typography, IconButton, Button } from '@mui/material';
import { useAuth } from '../../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import LogoutIcon from '@mui/icons-material/Logout';

const Layout = ({ children }) => {
  const { user, isAuthenticated, logoutUser } = useAuth();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await logoutUser();
    navigate('/');
  };

  return (
    <Box
      sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', width: '100vw', minHeight: '100vh', padding: 2 }}
    >
      {isAuthenticated && user && (
        <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', width: '100%' }}>
          <Box sx={{ display: 'flex', alignItems: 'center', marginBottom: 2 }}>
            <IconButton>
              <AccountCircleIcon />
            </IconButton>
            <Typography variant="h6" sx={{ marginRight: 2 }}>
              Role {user.role} | User {user.email}
            </Typography>
            <IconButton onClick={handleLogout}>
              <LogoutIcon />
            </IconButton>
          </Box>
          <Box sx={{ display: 'flex', marginBottom: 2 }}>
            <Button onClick={() => navigate('/dashboard')} sx={{ marginRight: 2 }}>
              Dashboard
            </Button>
            <Button onClick={() => navigate('/books')}>
              Books
            </Button>
          </Box>
        </Box>
      )}
      <Box sx={{ width: '100%', maxWidth: '1200px', padding: 2 }}>
        {children}
      </Box>
    </Box>
  );
};

export default Layout;
