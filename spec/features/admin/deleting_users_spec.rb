require 'spec_helper'

feature 'Deleting Users' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }
  let!(:user)       { FactoryGirl.create(:user) }

  before do
    sign_in_as!(admin_user)
    visit '/'

    click_link "Admin"
    click_link "Users"
  end

  scenario "Deleting a user" do
    click_link user
    click_link "Delete User"

    expect(page).to have_content("User has been deleted.")
  end

  scenario "User cannot delete themselves" do
    click_link admin_user
    click_link "Delete User"

    expect(page).to have_content("You cannot delete yourself!")
  end
end