class User < ApplicationRecord
  has_secure_password
  has_many :borrowings
  has_many :books, through: :borrowings

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  enum :role, { member: 0, librarian: 1 }

  def librarian?
    role == "librarian"
  end

  def member?
    role == "member"
  end

  def not_borrowed_books
    Book.where.not(id: borrowings.active.pluck(:book_id))
  end
end
