import React, { useState, useEffect } from 'react';
import { getDashboard } from '../../services/dashboard';
import { returnBook } from '../../services/borrowings';
import { Container, Typography, Box, CircularProgress, Card, Button } from '@mui/material';
import { CardContent, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from '@mui/material';

function LibrarianDashboard() {
  const [dashboardData, setDashboardData] = useState(null)

  useEffect(() => { fetchDashboardData() }, [])

  const fetchDashboardData = async () => {
    try {
      const data = await getDashboard()
      setDashboardData(data)
    } catch (error) { console.error('Failed to fetch dashboard data:', error) }
  };

  const handleReturn = async (borrowingId) => {
    try {
      await returnBook(borrowingId)
      fetchDashboardData()
    } catch (error) { console.error('Failed to return book:', error) }
  };

  if (!dashboardData) return (
    <Container>
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
        <CircularProgress />
      </Box>
    </Container>
  );

  return (
    <Box display="flex" justifyContent="center" alignItems="center" padding={2}>
      <Card sx={{ width: '100%', maxWidth: 800 }}>
        <CardContent>
          <Typography variant="h4" gutterBottom>Dashboard</Typography>

          <Box sx={{ mb: 4 }}>
            <Typography variant="h6" gutterBottom>Total Books: {dashboardData.total_books}</Typography>
            <Typography variant="h6" gutterBottom>Total Borrowed Books: {dashboardData.total_borrowed_books}</Typography>
            <Typography variant="h6" gutterBottom>Total Overdue Books: {dashboardData.overdue_books.length}</Typography>
            <Typography variant="h6" gutterBottom>Books Due Today: {dashboardData.books_due_today}</Typography>
          </Box>

          <Box sx={{ mb: 4 }}>
            <Typography variant="h6" gutterBottom>Overdue Books:</Typography>
            <TableContainer component={Paper}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>User Email</TableCell>
                    <TableCell>Book Title</TableCell>
                    <TableCell>Due Date</TableCell>
                    <TableCell align="right">Action</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {dashboardData.overdue_books.length > 0 ? (
                    dashboardData.overdue_books.map((entry, index) => (
                      <TableRow key={index}>
                        <TableCell>{entry.user_email}</TableCell>
                        <TableCell>{entry.book_title}</TableCell>
                        <TableCell>{entry.due_date}</TableCell>
                        <TableCell align="right">
                          <Button 
                            variant="contained" 
                            color="primary" 
                            onClick={() => handleReturn(entry.borrowing_id)}
                          >
                            Return
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow>
                      <TableCell colSpan={4}>No overdue books.</TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </TableContainer>
          </Box>

          <Box>
            <Typography variant="h6" gutterBottom>Borrowed Books:</Typography>
            <TableContainer component={Paper}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>User Email</TableCell>
                    <TableCell>Book Title</TableCell>
                    <TableCell>Due Date</TableCell>
                    <TableCell align="right">Action</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {dashboardData.borrowed_books && dashboardData.borrowed_books.length > 0 ? (
                    dashboardData.borrowed_books.map((entry, index) => (
                      <TableRow key={index}>
                        <TableCell>{entry.user_email}</TableCell>
                        <TableCell>{entry.book_title}</TableCell>
                        <TableCell>{entry.due_date}</TableCell>
                        <TableCell align="right">
                          <Button 
                            variant="contained" 
                            color="primary" 
                            onClick={() => handleReturn(entry.borrowing_id)}
                          >
                            Return
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow>
                      <TableCell colSpan={3}>No borrowed books.</TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </TableContainer>
          </Box>

        </CardContent>
      </Card>
    </Box>
  );
}

export default LibrarianDashboard;
