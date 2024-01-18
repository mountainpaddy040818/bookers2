class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update,]
  
  def new
    @user = User.new(user_params) 
    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully." 
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "errors prohibited this obj from being saved:"
      render "users/sign_up"
    end 
  end 
  
  def index
    @users = User.all
    @user = current_user
    @books = Book.all
    @book = Book.new
  end 
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to "/users/#{current_user.id}"
    else
      flash[:notice] = "errors prohibited this obj from being saved:"
      render :edit
    end 
  end 
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end 
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end 
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to book_path
    end 
  end 
  
end
