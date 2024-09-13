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
      .joins(:user, :book)
      .where.not("due_date < ?", Time.now.utc.to_date)
      .order("due_date ASC")
      .pluck("users.email", "books.title", "borrowings.id", "borrowings.due_date")
      .map do |email, title, id, due_date|
        {
          user_email: email,
          book_title: title,
          borrowing_id: id,
          due_date: due_date
        }
      end
  end

  def books_due_today
    Borrowing.due_today.count
  end

  def overdue_books
    Borrowing.active
      .joins(:user, :book)
      .where("due_date < ?", Time.now.utc.to_date)
      .pluck("users.email", "books.title", "borrowings.id", "borrowings.due_date")
      .map do |email, title, id, due_date|
        {
          user_email: email,
          book_title: title,
          borrowing_id: id,
          due_date: due_date
        }
      end
  end
end
