class Api::V1::UsersController < Api::ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :set_user, only: [:show]

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = [ user.id, Time.current.to_i ].join(":")
      render json: { user: user, message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: { user: user_data(@user) }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
