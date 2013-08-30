module CapybaraHelpers
  def assert_no_link_for(text)
    expect(page).to_not(have_css("a", text: text), "Expected not to see the #{text.inspect} link, but did.")
  end

  def assert_link_for(text)
    expect(page).to(have_css("a", text: text), "Expected to see the #{text.inspect} link, but did not.")
  end

  def check_permission_box(permission, object)
    check "permissions_#{object.id}_#{permission.parameterize("_")}"
  end

  def state_line_for(state)
    state = State.find_by_name!(state)
    "#state_#{state.id}"
  end
end

RSpec.configure do |c|
  c.include CapybaraHelpers, type: :feature
end