require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  describe 'validations' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    it 'prevents a user from borrowing the same book more than once' do
      create(:borrowing, user: user, book: book)
      borrowing = build(:borrowing, user: user, book: book)
      expect(borrowing).not_to be_valid
      expect(borrowing.errors[:base]).to include("You have already borrowed this book.")
    end
  end

  describe 'callbacks' do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    it 'decreases available copies after creation' do
      expect {
        create(:borrowing, book: book, user: user)
      }.to change { book.available_copies }.by(-1)
    end

    it 'increases available copies when returned' do
      borrowing = create(:borrowing, book: book, user: user, returned: true)
      expect {
        borrowing.update(returned: false)
      }.to change { book.available_copies }.by(-1)
    end
  end
end
