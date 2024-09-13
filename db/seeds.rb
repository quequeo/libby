require 'faker'

namespace :db do
  namespace :seed do
    desc "Clean existing data"
    task clean: :environment do
      puts "Cleaning existing data..."
      Borrowing.destroy_all
      Book.destroy_all
      User.destroy_all
    end

    desc "Create member users"
    task members: :environment do
      puts "Creating member users..."
      10.times do
        User.create!(
          email: Faker::Internet.email,
          password: 'password123'
        )
      end
    end

    desc "Create member user for testing"
    task member: :environment do
      puts "Creating member..."
      User.create!(
        email: 'member@libby.com',
        password: 'password123',
      )
    end

    desc "Create librarian"
    task librarian: :environment do
      puts "Creating librarian..."
      User.create!(
        email: 'librarian@libby.com',
        password: 'password123',
        role: :librarian
      )
    end

    desc "Create books"
    task books: :environment do
      puts "Creating books..."
      100.times do
        Book.create!(
          title: Faker::Book.title,
          author: Faker::Book.author,
          genre: Faker::Book.genre,
          isbn: Faker::Code.isbn,
          total_copies: rand(1..20)
        )
      end
    end

    desc "Create borrowings"
    task borrowings: :environment do
      puts "Creating borrowings..."
      50.times do
        user = User.all.sample
        book = Book.all.sample
        due_date = Faker::Date.between(from: 2.days.ago, to: 30.days.from_now)

        begin
          Borrowing.create!(
            user: user,
            book: book,
            due_date: due_date,
            returned: Faker::Boolean.boolean(true_ratio: 0.7)
          )
        rescue
          next
        end
      end
    end

    desc "Create overdue books"
    task overdue_books: :environment do
      puts "Creating overdue books..."
      20.times do
        user = User.all.sample
        book = Book.all.sample

        due_date = Faker::Date.between(from: 2.months.ago, to: 1.day.ago)

        begin
          Borrowing.create(
            user: user,
            book: book,
            due_date: due_date,
            returned: false
          )
        rescue
          next
        end
      end
    end

    desc "Run all seeding tasks"
    task all: [ :clean, :members, :member, :librarian, :books, :borrowings ] do
      puts "All seeds created successfully!"
    end
  end
end

# Run all tasks by default
Rake::Task["db:seed:all"].invoke
