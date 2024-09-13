import api from './api';

export const login = async (credentials) => {
  const response = await api.post('/login', credentials);
  localStorage.setItem('session_id', response.data.session_id);
  localStorage.setItem('token', response.data.token);
  return response.data;
};

export const register = async (userData) => {
  const response = await api.post('/users', { user: userData });
  localStorage.setItem('session_id', response.data.session_id);
  localStorage.setItem('token', response.data.token);
  return response.data;
};

export const logout = async () => {
  await api.delete('/logout');
  localStorage.removeItem('session_id');
};