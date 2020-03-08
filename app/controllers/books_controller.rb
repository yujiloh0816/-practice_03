class BooksController < ApplicationController

  def create
    @books = Book.all
    super
  end

  private

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def authenticate_action!
    redirect_to books_path unless current_user.books.pluck(:id).include?(params[:id].to_i)
  end

end
