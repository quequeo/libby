class Api::V1::AuthController < Api::BaseController
  skip_before_action :authenticate_user!, only: [ :login ]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = [ user.id, Time.current.to_i ].join(":")
      render json: { user: user, session_id: session[:user_id] }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def logout
    session[:user_id] = nil
    render json: { message: "Logged out successfully" }, status: :ok
  end
end
