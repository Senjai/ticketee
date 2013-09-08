require 'spec_helper'

feature 'Searching' do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:project) {FactoryGirl.create(:project)}
  let!(:ticket_1) do
    FactoryGirl.create(:ticket,
                       title: "Create Projects",
                       project: project,
                       user: user,
                       tag_names: "iteration_1")
  end

  let!(:ticket_2) do
    FactoryGirl.create(:ticket,
                       title: "Create Users",
                       project: project,
                       user: user,
                       tag_names: "iteration_2")
  end

  before do
    ["view", "tag"].each {|x| define_permission!(user, x, project)}
    sign_in_as!(user)
    visit '/'
    click_link project.name
  end

  scenario "Finding By Tag" do
    fill_in "Search", with: "tag:iteration_1"
    click_button "Search"

    within("#tickets") do
      page.should have_content("Create Projects")
      page.should_not have_content("Create Users")
    end
  end

  scenario "Clicking a tag will redirect to a list of tickets with that tag" do
    click_link("Create Projects")
    click_link("iteration_1")

    within("#tickets") do
      page.should have_content("Create Projects")
      page.should_not have_content("Create Users")
    end
  end
end