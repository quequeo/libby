Libby
Libby is a library management system built with Ruby on Rails and React.


Setup
Backend (Rails)

Navigate to the project directory:
cd libby

Install dependencies:
bundle install

Set up the database:
rails db:create db:migrate db:seed

Start the Rails server:
rails s


Frontend (React)

Navigate to the frontend directory:
cd frontend

Install dependencies:
npm install

Start the development server:
npm run dev


Visit http://localhost:5173 to see the application in action.
Testing
Run the test suite with:
rspec