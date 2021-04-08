class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @userinfo = @book.user
  end

  def index
    @books = Book.all
    @newbook = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:booknew] = "You have created book successfully."
      redirect_to book_path(@newbook.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @newbook = Book.new
    @userinfo = current_user
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:bookupdate] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.user_id = current_user.id
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  private
  def correct_user
     book = Book.find(params[:id])
     if current_user != book.user
       redirect_to books_path
     end
  end

end

