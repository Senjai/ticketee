class TagsController < ApplicationController
  before_action :require_signin!

  def remove
    @ticket = Ticket.find(params[:ticket_id])
    if can?(:tag, @ticket.project) || current_user.admin?
      @tag = Tag.find(params[:id])
      @ticket.tags -= [@tag]
      @ticket.save
    end
  end
end
