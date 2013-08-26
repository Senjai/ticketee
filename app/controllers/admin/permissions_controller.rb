class Admin::PermissionsController < Admin::BaseController
  before_action :set_user

  def index
    @ability = Ability.new(@user)
    @projects = Project.all
  end

  def set
    @user.permissions.clear
    params[:permissions].each do |id, permissions|
      project = Project.find(id)
      permissions.each do |permission, checked|
        Permission.create!(user: @user, thing: project, action: permission)
      end
    end

    redirect_to admin_user_permissions_path(@user), notice: "Permissions updated."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
