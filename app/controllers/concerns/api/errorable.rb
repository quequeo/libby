module Api
  module Errorable
    extend ActiveSupport::Concern

    included do
      rescue_from CanCan::AccessDenied,                 with: :forbidden
      rescue_from ActiveRecord::RecordNotFound,         with: :not_found
      rescue_from ActiveRecord::RecordInvalid,          with: :unprocessable_entity
      rescue_from ActionController::ParameterMissing,   with: :bad_request
      rescue_from StandardError,                        with: :internal_server_error
      rescue_from ActiveRecord::RecordNotUnique,        with: :unprocessable_entity
    end

    private

    def forbidden(exception)
      render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
    end

    def not_found(exception)
      render json: { error: 'Record not found' }, status: :not_found
    end

    def unprocessable_entity(exception)
      render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def bad_request(exception)
      render json: { error: exception.message }, status: :bad_request
    end

    def internal_server_error(exception)
      render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
    end
  end
end