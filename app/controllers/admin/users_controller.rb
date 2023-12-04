class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, except: [:new, :create, :index]

  def new
    @user = User.new
    authorize @user
  end

  def index
    @users = User.search(params[:query]).presence || User.all
    @pagy, @users = pagy(@users)
    authorize @users
  end

  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        send_welcome_email(@user, params[:user][:password])
        format.html { redirect_to admin_user_path(@user), notice: "User successfully created" }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize @user
  end
  
  def edit
    authorize @user
  end

  def update
    remove_password_params_if_blank
    respond_to do |format|
      if @user.update(user_params)
        authorize @user
        format.html { redirect_to admin_user_path(@user), notice: "User sucessfully updated" }
      else
        format.html { render action: 'edit' }
        format.json { render json: ser.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @user
  end

  def activate_user
    update_user_activity(true)
    #Account activation email
  end

  def in_activate_user
    update_user_activity(false)
    #TODO
    #Account deactivation email
  end

  private
  
  def get_user
    @user = User.find(params[:id])
  end

  def send_welcome_email(user, password)
    UserMailer.welcome_email(user, password).deliver_later
  end

  def remove_password_params_if_blank
    if params[:user][:password].blank?
      params[:user].except!(:password, :password_confirmation)
    end
  end

  def update_user_activity(active)
    @user.update_attribute(:is_active, active)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "user_#{@user.id}",
          partial: 'admin/users/active_buttons',
          locals: { user: @user }
        )
      end
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation)
  end
end
