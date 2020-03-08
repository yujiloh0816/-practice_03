class BooksController < ApplicationController

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.build(book_params)
    @books = Book.all

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :index }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
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
