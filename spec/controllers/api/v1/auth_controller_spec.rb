require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  describe '#login' do
    let(:user) { create(:user, email: 'librarian@libby.com', password: 'password123') }

    context 'with valid credentials' do
      it 'returns a success response' do
        post :login, params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status' do
        post :login, params: { email: user.email, password: '123456789' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#logout' do
    let(:user) { create(:user) }

    before { session[:user_id] = user.id }

    it 'returns a success response adn deletes session_id' do
      delete :logout
      expect(response).to have_http_status(:ok)
      expect(session[:user_id]).to be_nil
    end
  end
end
