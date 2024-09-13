import api from './api';

export const login = async (credentials) => {
  const response = await api.post('/login', credentials);
  return response.data.user
};

export const register = async (userData) => {
  const response = await api.post('/users', { user: userData });
  return response.data.user
};

export const logout = async () => {
  await api.delete('/logout');
};