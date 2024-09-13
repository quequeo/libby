import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getBookById, updateBook } from '../../services/books';
import { Box, TextField, Button, Typography, Container } from '@mui/material';

function EditBookForm() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [title, setTitle] = useState('');
  const [author, setAuthor] = useState('');
  const [genre, setGenre] = useState('');
  const [isbn, setIsbn] = useState('');
  const [totalCopies, setTotalCopies] = useState(1);

  useEffect(() => {fetchBookDetails(id)}, [id])

  const fetchBookDetails = async (bookId) => {
    try {
      const data = await getBookById(bookId);

      if (data) {
        setTitle(data.title);
        setAuthor(data.author);
        setGenre(data.genre);
        setIsbn(data.isbn);
        setTotalCopies(data.total_copies);
      }
    } catch (error) {console.error('Failed to fetch book details:', error)}
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await updateBook(id, {title, author, genre, isbn, total_copies: totalCopies});
      navigate('/books');
    } catch (error) {console.error('Failed to update book:', error)}
  }

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
        <Typography variant="h4" gutterBottom>Edit Book</Typography>
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
          Save Changes
        </Button>
      </Box>
    </Container>
  );
}

export default EditBookForm;
