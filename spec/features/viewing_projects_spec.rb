require 'spec_helper'

feature 'Viewing Projects' do
  let!(:user) { FactoryGirl.create(:user )}
  let!(:project) { FactoryGirl.create(:project) }

  before do
    sign_in_as! user
    define_permission!(user, :view, project)
  end

  scenario "Listing all projects" do
    project = FactoryGirl.create(:project, name: "Textmate 2")

    visit '/'
    click_link 'Textmate 2'
    # expect(page.current_url).to eql(project_url(project))
  end
end