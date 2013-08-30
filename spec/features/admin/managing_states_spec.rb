require 'spec_helper'

feature 'Creating states' do
  before do
    load Rails.root + "db/seeds.rb"
    sign_in_as!(FactoryGirl.create(:admin_user))
  end

  scenario 'Creating a state' do
    click_link "Admin"
    click_link "States"

    within state_line_for("New") do
      click_link "Make Default"
    end

    page.should have_content("New is now the default state.")
  end
end