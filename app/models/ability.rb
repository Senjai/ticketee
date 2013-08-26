class Ability
  include CanCan::Ability

  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.intern,
          permission.thing_type.constantize do |thing|
            thing.nil? || permission.thing.nil? || permission.thing_id == thing.id
          end
    end
  end
end