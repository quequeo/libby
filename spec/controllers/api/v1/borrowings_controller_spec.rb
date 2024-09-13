require 'rails_helper'

RSpec.describe Api::V1::BorrowingsController, type: :controller do
  let(:librarian) { create(:user, :librarian) }
  let(:member) { create(:user, :member) }
  let(:book) { create(:book) }

  describe 'POST #create' do
    context 'when user is a librarian' do
      before { sign_in librarian }

      context 'with valid params' do
        let(:valid_params) { { borrowing: { book_id: book.id, user_id: member.id } } }

        it 'creates a new Borrowing and returns 201 code' do
          expect {
            post :create, params: valid_params
          }.to change(Borrowing, :count).by(1)
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'when user is not authorized' do
      before { sign_in member }

      it 'returns a 403 status code' do
        post :create, params: { borrowing: { book_id: book.id } }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:borrowing) { create(:borrowing, user: member, book: book) }

    context 'when user is a librarian' do
      before { sign_in librarian }

      context 'with valid params' do
        let(:valid_params) { { id: borrowing.id, borrowing: { returned: true } } }

        it 'updates the requested borrowing' do
          patch :update, params: valid_params
          borrowing.reload
          expect(borrowing.returned).to be true
        end

        it 'returns the updated borrowing' do
          patch :update, params: valid_params
          expect(json_response['id']).to eq(borrowing.id)
          expect(json_response['returned']).to be true
        end
      end
    end
  end
end
