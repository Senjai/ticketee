class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :set_ticket

  def create
    sanitize_parameters!
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to [@ticket.project, @ticket], notice: "Added a comment!"
    else
      @states = State.all #for the nested rendere
      flash.now[:alert] = "Comment has not been created."
      render :template => "tickets/show"
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id, :tag_names)
  end

  def sanitize_parameters!
    unless can?(:"change states", @ticket.project) || current_user.admin?
      params[:comment].delete(:state_id)
    end

    unless can?(:tag, @ticket.project) || current_user.admin?
      params[:comment].delete(:tag_names)
    end
  end
end
