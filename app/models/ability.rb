class Ability
  include CanCan::Ability

  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.to_sym,
          permission.thing_type.constantize {|thing| thing.nil? || permission.thing.nil? || permission.thing_id == thing.id}
    end
  end
end