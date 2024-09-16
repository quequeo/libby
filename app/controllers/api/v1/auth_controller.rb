class Api::V1::AuthController < Api::ApplicationController
  skip_before_action :authenticate_user!, only: [:login]

  def login
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      user.session_token ||= SecureRandom.hex(20)
      user.save
      session[:user_id] = "#{user.id}|#{user.session_token}"
      render json: { user: user }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def logout
    current_user&.update(session_token: nil)
    session[:user_id] = nil
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
