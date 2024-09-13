import React from 'react';

function BookItem({ book, user }) {

  return (
    <div className="book-item">
      <h3>{book.title}</h3>
      <p>Author: {book.author}</p>
      <p>Genre: {book.genre}</p>
      {user && user.role === 'librarian' && (
        <p>ISBN: {book.isbn}</p>
      )}
      {user && user.role === 'librarian' && (
        <p>Total Copies: {book.total_copies}</p>
      )}
      <p>Available Copies: {book.available_copies}</p>
    </div>
  );
}

export default BookItem;