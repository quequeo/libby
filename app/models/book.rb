class Book < ApplicationRecord  
  has_many :borrowings

  validates :title, presence: true, length: { maximum: 60 }
  validates :author, presence: true, length: { maximum: 40 }
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :total_copies, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :search_by_attributes, ->(query) {
    where("title ILIKE :query OR author ILIKE :query OR genre ILIKE :query", query: "%#{query}%")
  }

  include Paginatable

  def available_copies
    total_copies - borrowings.active.count
  end
end
