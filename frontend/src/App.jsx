import React from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import Welcome from './components/StaticPages/Welcome';
import Login from './components/Auth/Login';
import Register from './components/Auth/Register';
import BookList from './components/Books/BookList';
import BookForm from './components/Books/BookForm';
import EditBookForm from './components/Books/EditBookForm';
import Dashboard from './components/Dashboard/Dashboard';
import Layout from './components/Styles/Layout';
import NotFound from './components/StaticPages/NotFound';

const theme = createTheme({ palette: { mode: 'dark' }, typography: { fontFamily: 'Roboto, sans-serif' }});

function PrivateRoute({ children }) {
  const { isAuthenticated, user } = useAuth();
  return isAuthenticated && user ? children : <Navigate to="/login" />;
}

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <AuthProvider>
        <Router>
          <Layout>
            <Routes>
              {/* STATIC PAGES */}
              <Route path="/" element={<Welcome />} />
              <Route path="*" element={<NotFound />} />

              {/* AUTH */}
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />

              {/* BOOKS */}
              <Route path="/books" element={<BookList />} />
              <Route path="/add-book" element={<BookForm />} />
              <Route path="/edit-book/:id" element={<EditBookForm />} />

              {/* DASHBOARD */}
              <Route path="/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
             
            </Routes>
          </Layout>
        </Router>
      </AuthProvider>
    </ThemeProvider>
  );
}

export default App;
