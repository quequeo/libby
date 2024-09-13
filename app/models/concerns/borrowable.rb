module Borrowable
  extend ActiveSupport::Concern

  included do
    scope :active,    -> { where(returned: false) }
    scope :overdue,   -> { active.where("due_date < ?", Date.current) }
    scope :due_today, -> { active.where(due_date: Time.now.utc.to_date) }
    scope :returned,  -> { where(returned: true) }

    before_validation :set_due_date, on: :create
    after_create :decrease_available_copies
    after_update :update_available_copies, if: :returned_changed?
  end

  private

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