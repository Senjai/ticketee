class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: SEUD
  before_action :require_signin!
  before_action :authorize_create!, only: [:new, :create]

  def new
    @ticket = @project.tickets.build
  end

  def index
    redirect_to @project
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: "Ticket has been updated."
    else
      flash[:alert] = "Ticket has not been updated."
      render action: "edit"
    end
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    if @ticket.save
      redirect_to [@project, @ticket], notice: "Ticket has been created."
    else
      flash[:alert] = "Ticket has not been created."
      render action: "new"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."

    redirect_to @project
  end

  private

  def set_project
    @project = Project.for(current_user).find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The project you were looking for could not be found"
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".intern, @project)
      redirect_to @project, alert: "You cannot create tickets on this project."
    end
  end
end
