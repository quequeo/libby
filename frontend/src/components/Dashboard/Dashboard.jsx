import { useAuth } from '../../contexts/AuthContext';
import LibrarianDashboard from './LibrarianDashboard';
import MemberDashboard from './MemberDashboard';

const Dashboard = () => {
  const { user } = useAuth();

  if (user.role === 'librarian') {
    return <LibrarianDashboard />;
  } else {
    return <MemberDashboard />;
  }
};

export default Dashboard;