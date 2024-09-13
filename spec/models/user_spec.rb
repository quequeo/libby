require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:borrowings) }
  it { should have_many(:books).through(:borrowings) }

  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6).on(:create) }

  describe '#not_borrowed_books' do
    let(:user) { create(:user) }
    let(:borrowed_book) { create(:book) }
    let(:not_borrowed_book) { create(:book) }

    before do
      create(:borrowing, user: user, book: borrowed_book)
    end

    it 'returns books that the user has not borrowed' do
      expect(user.not_borrowed_books).to include(not_borrowed_book)
      expect(user.not_borrowed_books).not_to include(borrowed_book)
    end
  end
end
