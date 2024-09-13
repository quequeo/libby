module AuthHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :controller
end
