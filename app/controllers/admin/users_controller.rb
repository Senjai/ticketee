class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: SEUD

  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def show

  end

  def edit

  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated."
    else
      flash.now[:alert] = "User has not been updated."
      render action: :edit
    end
  end

  def create
    @user = User.new(user_params)
    @user.password_confirmation ||= @user.password

    if @user.save
      redirect_to admin_users_path, notice: "User has been created."
    else
      flash.now[:alert] = "User has not been created."
      render action: :new
    end
  end

  def destroy
    if (@user != current_user) && @user.destroy
      redirect_to admin_users_path, notice: "User has been deleted."
    else
      flash.now[:alert] = "You cannot delete yourself!"
      render :show, id: @user.id
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :admin, :email)
  end
end
