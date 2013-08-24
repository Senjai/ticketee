module AuthorizationHelpers
  def define_permission!(user, action, thing)
    Permission.create!(user: user, action: action, thing: thing)
  end
end

RSpec.configure {|c| c.include AuthorizationHelpers}