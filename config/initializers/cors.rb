Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173"

    # Users
    resource '/api/v1/users',
    headers: :any, 
    methods: [:post],
    credentials: true

    # Auth
    resource '/api/v1/login',
    headers: :any,
    methods: [:post],
    credentials: true

    resource '/api/v1/logout',
    headers: :any,
    methods: [:delete],
    credentials: true

    # Books
    resource '/api/v1/books',
    headers: :any,
    methods: [:get, :post],
    credentials: true

    resource '/api/v1/books/*',
    headers: :any,
    methods: [:get, :put, :patch, :delete],
    credentials: true

    resource '/api/v1/books/search',
    headers: :any,
    methods: [:get],
    credentials: true

    # Borrowings
    resource '/api/v1/borrowings',
    headers: :any,
    methods: [:get, :post],
    credentials: true

    resource '/api/v1/borrowings/*',
    headers: :any,
    methods: [:get, :put, :patch],
    credentials: true

    # Dashboard
    resource '/api/v1/dashboard',
    headers: :any,
    methods: [:get],
    credentials: true
  end
end
