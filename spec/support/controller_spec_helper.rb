module ControllerSpecHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

RSpec.configure do |config|
  config.include ControllerSpecHelper, type: :controller
end
