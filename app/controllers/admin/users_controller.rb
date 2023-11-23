class Admin::UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :destroy]
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to admin_user_path(user)
    else
      render :new
    end
  end

  def show
    
  end
  
  def edit
   
  end

  def update
    @user = User.find
  end

  def destroy
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end
