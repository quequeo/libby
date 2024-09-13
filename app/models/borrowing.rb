class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true
  validate :user_cannot_borrow_same_book_more_than_once

  include Borrowable
  include Paginatable

  private

  def user_cannot_borrow_same_book_more_than_once
    return unless new_record? || book_id_changed?

    if active_borrowing_exists?
      errors.add(:base, 'You have already borrowed this book.')
    end
  end

  def active_borrowing_exists?
    Borrowing.active.exists?(user_id: user_id, book_id: book_id)
  end
end
