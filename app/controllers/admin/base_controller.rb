class Admin::BaseController < ApplicationController
  before_filter :authorize_admin!

  private

  def authorize_admin!
    require_signin!

    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to do that."
    end
  end
end