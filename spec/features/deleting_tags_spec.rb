require 'spec_helper'

feature "Deleting Tags" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project)}
  let!(:ticket) do
    FactoryGirl.create(:ticket, project: project, user: user, tag_names: "this-tag-must-die")
  end

  before do
    sign_in_as! user

    %W(view tag).each {|p| define_permission!(user, p, project)}

    visit '/'
    click_link project.name
    click_link ticket.title
  end

  scenario "Deleting a tag", js: true do
    click_link "delete-this-tag-must-die"

    within("#ticket #tags") do
      page.should_not have_content("this-tag-must-die")
    end
  end
end