class Book < ApplicationRecord
  has_many :borrowings

  validates :title, presence: true, length: { maximum: 250 }
  validates :author, presence: true, length: { maximum: 100 }
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :total_copies, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def available_copies
    total_copies - borrowings.active.count
  end
end
