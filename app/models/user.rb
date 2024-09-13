class User < ApplicationRecord
  has_secure_password
  has_many :borrowings
  has_many :books, through: :borrowings

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  include UserRoles

  def not_borrowed_books
    Book.where.not(id: borrowings.active.select(:book_id))
  end
end
