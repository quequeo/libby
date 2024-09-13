class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true
  validate :user_cannot_borrow_same_book_more_than_once

  before_validation :set_due_date, on: :create

  after_create :decrease_available_copies
  after_update :update_available_copies, if: :returned_changed?

  scope :active, -> { where(returned: false) }
  scope :overdue, -> { active.where("due_date < ?", Date.current) }
  scope :due_today, -> { active.where(due_date: Date.current) }
  scope :returned, -> { where(returned: true) }

  private

  def user_cannot_borrow_same_book_more_than_once
    if Borrowing.active.where(user_id: user_id, book_id: book_id).exists? && (new_record? || (persisted? && saved_change_to_book_id?))
      errors.add(:base, "You have already borrowed this book.")
    end
  end

  def set_due_date
    self.due_date ||= 2.weeks.from_now.to_date
  end

  def decrease_available_copies
    book.decrement!(:available_copies)
  end

  def update_available_copies
    if returned?
      book.increment!(:available_copies)
    else
      book.decrement!(:available_copies)
    end
  end
end
