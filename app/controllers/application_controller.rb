class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :find_states
  protect_from_forgery with: :exception

  SEUD = [:show, :edit, :update, :destroy].freeze

  private

  def require_signin!
    if current_user.nil?
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to signin_url
    end
  end
  helper_method :require_signin!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def find_states
    @states = State.all
  end
end
