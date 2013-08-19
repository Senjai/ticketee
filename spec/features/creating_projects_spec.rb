require 'spec_helper'

feature 'Creating Projects' do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))
    visit '/'
    click_link 'New Project'
  end

  scenario "can create a project" do
    fill_in 'Name', with: 'Sublime Text 3'
    fill_in 'Description', with: 'A text editor'
    click_button 'Create Project'

    expect(page).to have_content('Project has been created.')

    project = Project.where(name: 'Sublime Text 3').first
    expect(page.current_url).to eql(project_url(project))

    title = "Sublime Text 3 - Projects - Ticketee"
    expect(find("title").native.text).to have_content(title)
  end

  scenario "can not create a project without a name" do
    fill_in "Name", with: ""
    click_button 'Create Project'

    expect(page).to have_content("Project has not been created.")
    expect(page).to have_content("Name can't be blank")
  end
end