class Api::V1::BorrowingsController < Api::BaseController
  load_and_authorize_resource

  def index
    @borrowings = current_user.librarian? ? Borrowing.all : current_user.borrowings
    render json: @borrowings
  end

  def show
    render json: @borrowing
  end

  def create
    if @borrowing.save
      render json: @borrowing, status: :created
    else
      render json: @borrowing.errors, status: :unprocessable_entity
    end
  end

  def update
    if @borrowing.update(borrowing_params)
      render json: @borrowing
    else
      render json: @borrowing.errors, status: :unprocessable_entity
    end
  end

  private

  def borrowing_params
    params.require(:borrowing).permit(:book_id, :returned, :user_id)
  end
end
