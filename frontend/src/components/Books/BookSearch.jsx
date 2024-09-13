import React, { useState } from 'react';
import { Box, TextField, Button } from '@mui/material';
import { debounce } from 'lodash';

function BookSearch({ onSearch }) {
  const [searchQuery, setSearchQuery] = useState('');

  const handleSearch = debounce((value) => {
    onSearch(value);
  }, 600);

  const handleChange = (e) => {
    const value = e.target.value;
    setSearchQuery(value);
    handleSearch(value);
  };

  return (
    <Box display="flex" alignItems="center" marginBottom={2}>
      <TextField
        label="Search"
        variant="outlined"
        fullWidth
        value={searchQuery}
        onChange={handleChange}
        sx={{ marginRight: 1 }}
      />
      <Button variant="contained" onClick={() => onSearch(searchQuery)}>
        Search
      </Button>
    </Box>
  );
}

export default BookSearch;
