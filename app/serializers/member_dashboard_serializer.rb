class MemberDashboardSerializer < ActiveModel::Serializer
  attribute :borrowed_books
  attribute :overdue_books

  def borrowed_books
    object.borrowings.active.map do |borrowing|
      {
        id: borrowing.id,
        book_title: borrowing.book.title,
        book_author: borrowing.book.author,
        due_date: borrowing.due_date,
        created_at: borrowing.created_at.strftime("%Y-%m-%d"),
        returned: borrowing.returned
      }
    end
  end

  def overdue_books
    object.borrowings.overdue.map do |borrowing|
      {
        id: borrowing.id,
        book_title: borrowing.book.title,
        book_author: borrowing.book.author,
        due_date: borrowing.due_date,
        created_at: borrowing.created_at.strftime("%Y-%m-%d"),
        returned: borrowing.returned
      }
    end
  end
end
