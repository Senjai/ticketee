class ProjectsController < ApplicationController
  before_action :set_project, only: SEUD

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = 'Project has not been updated.'
      redirect_to edit_project_path(@project)
    end
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] = 'Project has not been created.'
      render action: :new
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: "Project has been destroyed."
    else
      redirect_to project_path(@project), alert: "Project has not been destroyed."
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking for could not be found."
    redirect_to projects_path
  end
end
