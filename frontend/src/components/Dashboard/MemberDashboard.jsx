import React, { useState, useEffect } from 'react';
import { getDashboard } from '../../services/dashboard';
import { Container, Typography, CircularProgress, Box, Card, CardContent } from '@mui/material';
import BorrowedBookList from '../Books/BorrowedBookList';

function MemberDashboard() {
  const [dashboardData, setDashboardData] = useState(null);

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      const data = await getDashboard();
      setDashboardData(data);
    } catch (error) {
      console.error('Failed to fetch dashboard data:', error);
    }
  };

  if (!dashboardData) return (
    <Container>
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
        <CircularProgress />
      </Box>
    </Container>
  );

  return (
    <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
      <Card sx={{ maxWidth: 800, width: '100%', p: 3 }}>
        <CardContent>
          <Typography variant="h4" gutterBottom>Dashboard</Typography>

          <BorrowedBookList books={dashboardData.borrowed_books} title="Borrowed Books" />
          <BorrowedBookList books={dashboardData.overdue_books} title="Overdue Books" />
        </CardContent>
      </Card>
    </Box>
  );
}

export default MemberDashboard;
