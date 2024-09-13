require 'rails_helper'

RSpec.describe LibrarianDashboardSerializer do
  let(:serializer) { LibrarianDashboardSerializer.new(nil) }
  let(:serialization) { JSON.parse(serializer.to_json) }

  before do
    create_list(:book, 3)
    user1 = create(:user, email: 'user1@libby.com')
    user2 = create(:user, email: 'user2@libby.com')
    book1 = create(:book, title: 'Book 1')
    book2 = create(:book, title: 'Book 2')
    create(:borrowing, user: user1, book: book1, due_date: Date.today)
    create(:borrowing, user: user2, book: book2, due_date: Date.tomorrow)
    create(:borrowing, user: user1, book: book2, due_date: Date.yesterday)
  end

  it 'includes the expected attributes' do
    expect(serialization.keys).to match_array([ 'total_books', 'total_borrowed_books', 'borrowed_books', 'books_due_today', 'overdue_books' ])
  end

  it 'serializes total_books correctly' do
    expect(serialization['total_books']).to eq(5)
  end

  it 'serializes total_borrowed_books correctly' do
    expect(serialization['total_borrowed_books']).to eq(3)
  end

  it 'serializes borrowed_books correctly' do
    borrowed_books = serialization['borrowed_books']
    expect(borrowed_books.length).to eq(3)
  end

  it 'serializes books_due_today correctly' do
    expect(serialization['books_due_today']).to eq(1)
  end

  it 'serializes overdue_books correctly' do
    overdue_books = serialization['overdue_books']
    expect(overdue_books.length).to eq(1)
  end
end
