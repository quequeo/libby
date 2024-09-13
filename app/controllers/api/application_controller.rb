class Api::ApplicationController < ApplicationController
  include Api::Pagination
  include Api::Errorable
  include ActionController::Cookies

  before_action :authenticate_user!

  private

  def current_user
    return @current_user if defined?(@current_user)
    return nil unless session[:user_id]

    user_id, token = session[:user_id].split('|')
    user = User.find_by(id: user_id)

    if user && user.session_token.present? && secure_compare(user.session_token, token)
      @current_user = user
    else
      session[:user_id] = nil
      nil
    end
  end

  def secure_compare(user_token,token)
    ActiveSupport::SecurityUtils.secure_compare(user_token, token)
  end

  def authenticate_user!
    render json: { error: 'Not authorized' }, status: :unauthorized unless current_user
  end

end
