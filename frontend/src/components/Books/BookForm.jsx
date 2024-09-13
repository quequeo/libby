import React, { useState } from 'react';
import { createBook } from '../../services/books';
import { Box, TextField, Button, Typography, Container } from '@mui/material';

function BookForm() {
  const [title, setTitle] = useState('');
  const [author, setAuthor] = useState('');
  const [genre, setGenre] = useState('');
  const [isbn, setIsbn] = useState('');
  const [totalCopies, setTotalCopies] = useState(1);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await createBook({ title, author, genre, isbn, total_copies: totalCopies });
      setTitle('');
      setAuthor('');
      setGenre('');
      setIsbn('');
      setTotalCopies(1);
      setError('');
    } catch (error) {
      console.error('Failed to add book:', error);
      if (error.response && error.response.data && error.response.data.error) {
        setError(error.response.data.error);
      } else {
        setError('Failed to add book. Please try again later.');
      }
    }
  };

  return (
    <Container maxWidth="sm">
      <Box
        component="form"
        onSubmit={handleSubmit}
        sx={{
          display: 'flex',
          flexDirection: 'column',
          gap: 2,
          padding: 3,
          borderRadius: 2,
          boxShadow: 3,
          marginTop: 5,
          backgroundColor: 'background.paper',
        }}
      > 
          {error && (
            <Typography color="error" sx={{ mt: 2 }}>
              {error}
            </Typography>
          )}
        <Typography variant="h4" gutterBottom>
          Add New Book
        </Typography>
        <TextField
          label="Title"
          variant="outlined"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          required
        />
        <TextField
          label="Author"
          variant="outlined"
          value={author}
          onChange={(e) => setAuthor(e.target.value)}
          required
        />
        <TextField
          label="Genre"
          variant="outlined"
          value={genre}
          onChange={(e) => setGenre(e.target.value)}
          required
        />
        <TextField
          label="ISBN"
          variant="outlined"
          value={isbn}
          onChange={(e) => setIsbn(e.target.value)}
          required
        />
        <TextField
          label="Total Copies"
          type="number"
          variant="outlined"
          value={totalCopies}
          onChange={(e) => setTotalCopies(parseInt(e.target.value))}
          min="1"
          required
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          sx={{ marginTop: 2 }}
        >
          Add Book
        </Button>
      </Box>
    </Container>
  );
}

export default BookForm;
