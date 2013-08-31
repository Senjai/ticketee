require 'spec_helper'

feature "Creating comments" do
  let!(:user)    { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket)  { FactoryGirl.create(:ticket, project: project, user: user) }

  before do
    define_permission!(user, "view", project)
    FactoryGirl.create(:state, name: "Open")

    sign_in_as!(user)
    visit '/'
    click_link project.name
  end

  scenario "Creating a comment" do
    click_link ticket.title
    fill_in("Text", with: "Added a comment!")
    click_button "Create Comment"

    page.should have_content("Added a comment!")
    within("#comments") do
      page.should have_content("Added a comment!")
    end
  end

  scenario "Changing a ticket's state" do
    define_permission!(user, :"change states", project)
    click_link ticket.title
    fill_in "Text", with: "This is a real issue"
    select "Open", from: "State"
    click_button "Create Comment"

    page.should have_content("Added a comment!")
    within("#ticket .state") do
      page.should have_content("Open")
    end

    within("#comments") do
      page.should have_content("State: Open")
    end
  end

  scenario "A ticket without permission cannot change the state" do
    click_link ticket.title
    find_element = lambda { find("#comment_state_id") }
    message = "Expected not to see #comment_state_id, but did."
    find_element.should(raise_error(Capybara::ElementNotFound), message)
  end

  scenario "Adding a tag to a ticket" do
    define_permission!(user, "tag", project)
    click_link ticket.title
    within("#ticket #tags") do
      page.should_not have_content("bug")
    end

    fill_in "Text", with: "Adding a bug tag"
    fill_in "Tags", with: "bug"
    click_button "Create Comment"

    page.should have_content("Added a comment!")
    within("#ticket #tags") do
      page.should have_content("bug")
    end
  end
end