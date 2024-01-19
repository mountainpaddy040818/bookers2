class BooksController < ApplicationController
  before_action :authenticate_user!
  # before_action :is_matching_login_user, {only: [:edit, :update, :destroy]}

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      flash[:notice] = "errors prohibited this obj from being saved;"
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = current_user
    @book_show = Book.find(params[:id])
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:notice] = "errors prohibited this obj from being saved:"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books', notice: '本を削除しました。'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  # def is_matching_login_user
    # @book = Book.find[:id]
    # if @book.user_id != current_user.id
      # redirect_to root_path, alert: '他のユーザーの投稿は編集できません。'
    # end
  # end

end
