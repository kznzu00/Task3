class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]

  def index
    @newbook = Book.new
    @users = User.all
    @userinfo = current_user
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @userinfo = @user
  end


  def edit
    @user = User.find(params[:id])
    @newbook = Book.new
    @userinfo = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:userupdate] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction )
  end

  private
  def correct_user
     user = User.find(params[:id])
     if current_user != user
       redirect_to user_path(current_user.id)
     end
  end
end
