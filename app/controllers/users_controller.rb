class UsersController < ApplicationController
  def index
    @users = User.all

    @user = current_user
    @newbook = Book.new
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new

    @book = @user.books
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:userinfo] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title ,:body)
  end

end
