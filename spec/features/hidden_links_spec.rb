require 'spec_helper'

feature "hidden links" do
  let(:user)    { FactoryGirl.create(:user)       }
  let(:admin)   { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project)    }

  context "Anonymous Users" do
    scenario "Cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "Cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "Cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "Regular Users" do
    before { sign_in_as! user }
    scenario "Cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "Cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "Cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "Admin Users" do
    before { sign_in_as! admin }
    scenario "Can see the New Project link" do
      visit '/'
      assert_link_for "New Project"
    end

    scenario "Can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "Can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end
  end
end