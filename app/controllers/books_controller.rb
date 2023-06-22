class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    session[:previous_url] = request.referer
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @book_new = Book.new
  end

  def index
    session[:previous_url] = request.referer
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    unless @user == current_user
      redirect_to books_path
    end
  end
end
