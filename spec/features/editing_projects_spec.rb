require 'spec_helper'

feature "Editing Projects" do
  before do
    FactoryGirl.create(:project, name: 'Textmate 2')

    visit '/'
    click_link 'Textmate 2'
    click_link 'Edit Project'
  end

  scenario "Updating a Project" do
    #in edit.html.erb

    fill_in "Name", with: "Textmate 2 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project without attributes is bad" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page.current_url).to eql(edit_project_url(Project.first.id))
    expect(page).to have_content("Project has not been updated.")
  end
end