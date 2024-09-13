import React, { useState, useEffect } from 'react';
import { getBooks, searchBooks, deleteBook } from '../../services/books';
import { createBorrowing } from '../../services/borrowings';
import { useNavigate } from 'react-router-dom';
import BookItem from './BookItem';
import BookSearch from './BookSearch';
import { Card, CardContent, Typography, CircularProgress, Box, Divider, Button } from '@mui/material';
import { useAuth } from '../../contexts/AuthContext';

function BookList() {
  const [books, setBooks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const { user } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    fetchBooks();
  }, []);

  const fetchBooks = async () => {
    try {
      setLoading(true);
      const data = await getBooks();
      if (data && data.books) {
        setBooks(data.books);
      } else {
        setBooks([]);
      }
    } catch (error) {
      console.error('Failed to fetch books:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchSearchedBooks = async (query) => {
    try {
      setLoading(true);
      const data = await searchBooks(query);
      if (data && data.books) {
        setBooks(data.books);
      } else {
        setBooks([]);
      }
    } catch (error) {
      console.error('Failed to search books:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = (query) => {
    if (query) {
      fetchSearchedBooks(query);
    } else {
      fetchBooks();
    }
  };

  const handleEdit = (bookId) => {
    navigate(`/edit-book/${bookId}`);
  };

  const handleDelete = async (bookId) => {
    try {
      await deleteBook(bookId);
      setBooks(books.filter((book) => book.id !== bookId));
    } catch (error) {
      console.error('Failed to delete book:', error);
    }
  };

  const handleBorrow = async (bookId) => {
    try {
      await createBorrowing(bookId, user.id);
      navigate('/dashboard');
    } catch (error) {
      console.error('Failed to borrow book:', error);
      if (error.response && error.response.data && error.response.data.error) {
        setError(error.response.data.error);
      } else {
        setError('Failed to borrow book. Please try again later.');
      }
    }
  };

  return (
    <Box display="flex" justifyContent="center" alignItems="center" padding={2}>
      <Card sx={{ width: '100%', maxWidth: 600 }}>
        <CardContent>
          <Typography variant="h5" component="div" gutterBottom>
            Book List
          </Typography>
          <BookSearch onSearch={handleSearch} />
          
          {loading ? (
            <Box display="flex" justifyContent="center" alignItems="center">
              <CircularProgress />
            </Box>
          ) : (
            <Box>
              {books.length > 0 ? (
                books.map((book, index) => (
                  <Box key={`${book.id}-${index}`}>
                    <BookItem book={book} user={user} />
                    {user && user.role === 'librarian' && (
                      <Box display="flex" justifyContent="flex-end" marginBottom={1}>
                        <Button
                          variant="outlined"
                          color="primary"
                          sx={{ marginRight: 1 }}
                          onClick={() => handleEdit(book.id)}
                        >
                          Edit
                        </Button>
                        <Button
                          variant="outlined"
                          color="error"
                          onClick={() => handleDelete(book.id)}
                          disabled={book.available_copies < book.total_copies}
                        >
                          Delete
                        </Button>
                      </Box>
                    )}
                    {user && user.role === 'member' && (
                      <Box display="flex" justifyContent="flex-end" marginBottom={1}>
                        <Button
                          variant="outlined"
                          color="primary"
                          onClick={() => handleBorrow(book.id)}
                          disabled={book.available_copies === 0}
                        >
                          Borrow
                        </Button>
                      </Box>
                    )}
                    <Divider sx={{ marginY: 1 }} />
                  </Box>
                ))
              ) : (
                <Typography>No books found</Typography>
              )}
            </Box>
          )}
        </CardContent>
      </Card>
    </Box>
  );
}

export default BookList;
