class LibrarianDashboardSerializer < ActiveModel::Serializer
  attribute :total_books
  attribute :total_borrowed_books
  attribute :borrowed_books
  attribute :books_due_today
  attribute :overdue_books

  def total_books
    Book.count
  end

  def total_borrowed_books
    Borrowing.active.count
  end

  def borrowed_books
    Borrowing.active
    .includes(:user, :book)
    .order(due_date: :asc)
    .map do |borrowing|
      {
        user_email: borrowing.user.email,
        book_title: borrowing.book.title,
        borrowing_id: borrowing.id,
        due_date: borrowing.due_date
      }
    end
  end

  def books_due_today
    Borrowing.due_today.count
  end

  def overdue_books
    Borrowing.active
    .includes(:user, :book)
    .where("due_date < ?", Time.now.utc.to_date)
    .order(due_date: :asc)
    .map do |overdue|
      {
        user_email: overdue.user.email,
        book_title: overdue.book.title,
        borrowing_id: overdue.id,
        due_date: overdue.due_date
      }
    end
  end
end
