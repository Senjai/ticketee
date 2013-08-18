class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to projects_path, notice: "You have signed up successfully."
    else
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(*%W{name email password password_confirmation}.map(&:intern))
  end
end
