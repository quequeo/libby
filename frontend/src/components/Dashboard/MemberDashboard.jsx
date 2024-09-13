import React, { useState, useEffect } from 'react';
import { getDashboard } from '../../services/dashboard';
import { returnBook } from '../../services/borrowings';
import { Container, Typography, CircularProgress, Box, Card, CardContent, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Button } from '@mui/material';

function MemberDashboard() {
  const [dashboardData, setDashboardData] = useState(null);

  useEffect(() => {fetchDashboardData()}, [])

  const fetchDashboardData = async () => {
    try {
      const data = await getDashboard();
      setDashboardData(data);
    } catch (error) {
      console.error('Failed to fetch dashboard data:', error);
    }
  };

  const handleReturn = async (borrowingId) => {
    try {
      await returnBook(borrowingId);
      fetchDashboardData();
    } catch (error) { console.error('Failed to return book:', error) }
  };

  if (!dashboardData) return (
    <Container>
      <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
        <CircularProgress />
      </Box>
    </Container>
  );

  const renderBookTable = (books, title) => (
    <Box sx={{ mb: 4 }}>
      <Typography variant="h6" gutterBottom>{title}:</Typography>
      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Book Title</TableCell>
              <TableCell>Due Date</TableCell>
              <TableCell align="right">Action</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {books.length > 0 ? (
              books.map((book, index) => (
                <TableRow key={index}>
                  <TableCell>{book.book_title}</TableCell>
                  <TableCell>{book.due_date}</TableCell>
                  <TableCell align="right">
                    <Button 
                      variant="contained" 
                      color="primary" 
                      onClick={() => handleReturn(book.id)}
                    >
                      Return
                    </Button>
                  </TableCell>
                </TableRow>
              ))
            ) : (
              <TableRow>
                <TableCell colSpan={3}>No {title.toLowerCase()}.</TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
      </TableContainer>
    </Box>
  );

  return (
    <Box display="flex" justifyContent="center" alignItems="center" padding={2}>
      <Card sx={{ width: '100%', maxWidth: 800 }}>
        <CardContent>
          <Typography variant="h4" gutterBottom>Dashboard</Typography>

          {renderBookTable(dashboardData.borrowed_books, "Borrowed Books")}
          {renderBookTable(dashboardData.overdue_books, "Overdue Books")}
        </CardContent>
      </Card>
    </Box>
  );
}

export default MemberDashboard;