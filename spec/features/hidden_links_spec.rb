require 'spec_helper'

feature "hidden links" do
  let(:user)    { FactoryGirl.create(:user)       }
  let(:admin)   { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project)    }
  let(:ticket)  { FactoryGirl.create(:ticket, project: project, user: user) }


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

    scenario "New Ticket link is shown with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "New Ticket link is not shown without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end

    scenario "Edit ticket link is shown to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      define_permission!(user, "edit tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario "Edit ticket link is hidden from a user without permission" do
      ticket
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
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

    scenario "New Ticket link is shown to all admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "Edit ticket link is shown to admins" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
  end
end