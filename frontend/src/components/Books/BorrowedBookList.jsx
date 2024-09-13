import React from 'react';
import BorrowedBookItem from './BorrowedBookItem';
import { Box, List, Typography } from '@mui/material';

function BorrowedBookList({ books, title }) {
  return (
    <Box mb={4}>
      <Typography variant="h6" gutterBottom>{title}:</Typography>
      <List>
        {books.length > 0 ? (
          books.map((book) => (
            <BorrowedBookItem key={book.id} book={book} />
          ))
        ) : (
          <Typography>No books found.</Typography>
        )}
      </List>
    </Box>
  );
}

export default BorrowedBookList;
