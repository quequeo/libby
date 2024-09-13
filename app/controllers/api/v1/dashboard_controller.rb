class Api::V1::DashboardController < Api::BaseController
  def index
    if current_user.librarian?
      render json: current_user, serializer: LibrarianDashboardSerializer
    else
      render json: current_user, serializer: MemberDashboardSerializer
    end
  end
end
