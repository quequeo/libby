require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  let(:librarian) { create(:user, :librarian) }
  let(:member) { create(:user, :member) }
  let(:book) { create(:book) }

  describe 'DELETE #destroy' do
    context 'when the user is a librarian' do
      before { sign_in librarian }

      context 'when the book has no borrowings' do
        it 'deletes the book' do
          delete :destroy, params: { id: book.id }
          expect(response).to have_http_status(:no_content)
          expect(Book.exists?(book.id)).to be_falsey
        end
      end

      context 'when the book has borrowings and all are returned' do
        before do
          create(:borrowing, book: book, user: member, returned: true)
        end

        it 'deletes the book and associated borrowings' do
          delete :destroy, params: { id: book.id }
          expect(response).to have_http_status(:no_content)
          expect(Book.exists?(book.id)).to be_falsey
          expect(Borrowing.where(book_id: book.id)).to be_empty
        end
      end

      context 'when the book has active borrowings (not returned)' do
        before do
          create(:borrowing, book: book, user: member, returned: false)
        end

        it 'does not delete the book and returns an error' do
          delete :destroy, params: { id: book.id }
          expect(response).to have_http_status(:forbidden)
          expect(json_response['error']).to eq('Cannot delete a book that is currently borrowed')
          expect(Book.exists?(book.id)).to be_truthy
        end
      end
    end
  end
end
