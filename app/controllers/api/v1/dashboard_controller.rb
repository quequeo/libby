class Api::V1::DashboardController < Api::ApplicationController
  def index
    if current_user.librarian?
      render json: current_user, serializer: LibrarianDashboardSerializer
    else
      render json: current_user, serializer: MemberDashboardSerializer
    end
  end
end
