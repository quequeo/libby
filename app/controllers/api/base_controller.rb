class Api::BaseController < ApplicationController
  include Pagination

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: "Not authorized" }, status: :unauthorized
  end
end
