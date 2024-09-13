import React, { createContext, useState, useContext, useEffect } from 'react';
import { login, register, logout } from '../services/auth';

const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [isAuth, setIsAuth] = useState(false);

  useEffect(() => {
    const sessionId = localStorage.getItem('session_id');
    const storedUser = JSON.parse(localStorage.getItem('user'));
    if (sessionId && storedUser) {
      setIsAuth(true);
      setUser(storedUser);
    }
  }, []);

  const loginUser = async (credentials) => {
    try {
      const data = await login(credentials);
      setUser(data.user);
      setIsAuth(true);
      localStorage.setItem('user', JSON.stringify(data.user));
      return data.user;
    } catch (error) {
      console.error('Login failed:', error);
      throw error;
    }
  };

  const registerUser = async (userData) => {
    try {
      const data = await register(userData);
      setUser(data.user);
      setIsAuth(true);
      localStorage.setItem('user', JSON.stringify(data.user));
      return data.user;
    } catch (error) {
      console.error('Registration failed:', error);
      throw error;
    }
  };

  const logoutUser = async () => {
    try {
      await logout();
      setUser(null);
      setIsAuth(false);
      localStorage.removeItem('user');
    } catch (error) {
      console.error('Logout failed:', error);
    }
  };

  return (
    <AuthContext.Provider value={{ 
      user,
      isAuthenticated: isAuth,
      loginUser, 
      registerUser, 
      logoutUser
    }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}