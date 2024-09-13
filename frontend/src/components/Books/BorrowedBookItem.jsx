import React from 'react';
import { ListItem, ListItemText } from '@mui/material';

function BorrowedBookItem({ book }) {
  return (
    <ListItem>
      <ListItemText
        primary={book.book_title}
        secondary={`Author: ${book.book_author} | Due: ${book.due_date}`}
      />
    </ListItem>
  );
}

export default BorrowedBookItem;
