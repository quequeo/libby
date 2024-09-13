require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  let(:librarian) { create(:user, :librarian) }
  let(:member) { create(:user, :member) }

  describe 'GET #index' do
    context 'when user is a librarian' do
      before do
        sign_in librarian
        create_list(:book, 5)
      end

      it 'returns all books' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(json_response['books'].length).to eq(5)
      end
    end

    context 'when user is a member' do
      before do
        sign_in member
        @borrowed_book = create(:book)
        create(:borrowing, user: member, book: @borrowed_book)
        @not_borrowed_books = create_list(:book, 4)
      end

      it 'returns only not borrowed books' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(json_response['books'].length).to eq(4)
        book_ids = json_response['books'].map { |book| book['id'] }
        expect(book_ids).not_to include(@borrowed_book.id)
      end
    end
  end

  describe 'GET #search' do
    before do
      sign_in member
      @book1 = create(:book, title: 'Ruby Programming')
      @book2 = create(:book, title: 'Python Programming')
      @borrowed_book = create(:book, title: 'Ruby on Rails')
      create(:borrowing, user: member, book: @borrowed_book)
    end

    it 'returns books matching the search query' do
      get :search, params: { query: 'Ruby' }
      expect(response).to have_http_status(:ok)
      expect(json_response['books'].length).to eq(1)
      expect(json_response['books'].first['title']).to eq('Ruby Programming')
    end

    it 'does not return borrowed books' do
      get :search, params: { query: 'Ruby' }
      book_ids = json_response['books'].map { |book| book['id'] }
      expect(book_ids).not_to include(@borrowed_book.id)
    end
  end
end
