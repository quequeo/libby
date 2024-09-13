class Api::V1::BooksController < Api::ApplicationController
  load_and_authorize_resource

  def index
    @books = current_user.librarian? ? Book.all : current_user.not_borrowed_books
    @books = @books.order(updated_at: :desc).paginate(params[:page], params[:per_page])
    render json: { books: books_serializer, meta: pagination_meta(@books) }
  end

  def show
    render json: @book
  end

  def create
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @book.borrowings.where(returned: false).exists?
      render json: { error: 'Cannot delete a book that is currently borrowed' }, status: :forbidden
    else
      @book.borrowings.destroy_all
      @book.destroy
      head :no_content
    end
  end

  def search
    @books = BookFinder.search(params[:query], page: params[:page], per_page: params[:per_page])
    @books = @books.where.not(id: current_user.borrowings.active.pluck(:book_id))
    render json: { books: books_serializer, meta: pagination_meta(@books) }
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
  end

  def books_serializer
    ActiveModelSerializers::SerializableResource.new(@books, each_serializer: BookSerializer)
  end
end
