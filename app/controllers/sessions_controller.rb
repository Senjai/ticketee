class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.where(name: params[:signin][:name]).first

    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in successfully."
    else
      flash[:error] = "Sorry."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out successfully."
  end
end