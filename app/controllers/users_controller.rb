class UsersController < ApplicationController
  before_action :set_user, only: SEUD

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to projects_path, notice: "You have signed up successfully."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to projects_path, notice: "Profile has been updated."
    else
      redirect_to [:edit, @user], alert: "FAYUL"
    end
  end

  def destroy
    @user.destroy

    redirect_to projects_path, notice: "User destroyed"
  end

  private

  def user_params
    params.require(:user).permit(*%W{name email password password_confirmation}.map(&:intern))
  end

  def set_user
    @user = User.find(params[:id])
  end
end
