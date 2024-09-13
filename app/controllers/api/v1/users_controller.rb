class Api::V1::UsersController < Api::ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.new(user_params)
    user.session_token = SecureRandom.hex(20)

    if user.save
      session[:user_id] = "#{user.id}|#{user.session_token}"
      render json: { user: user, message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end