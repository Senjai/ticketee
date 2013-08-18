class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

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
    @project = Project.find(params[:id])

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
end
