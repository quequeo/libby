import api from './api';

export const createBorrowing = async (bookId, userId) => {
  try {
    const response = await api.post('/borrowings', { borrowing: { book_id: bookId, user_id: userId}});
    return response.data;
  } catch (error) {
    console.error('Error borrowing book:', error);
    throw error;
  }
};

export const returnBook = async (borrowingId) => {
  await api.patch(`/borrowings/${borrowingId}`, { returned: true });
};
