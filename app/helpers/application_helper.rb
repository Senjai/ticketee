module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&block)
    block.call if block_given? && current_user.try(:admin?)
  end

  def authorized?(permission, thing, &block)
    block.call if can?(permission.intern, thing) || current_user.try(:admin?)
  end
end
