### UTILITY METHODS ###

def create_example_project
  @example_project ||= { :name => "Test Project"}
end

def find_project
  @project ||= Project.first conditions: {:name => @example_project[:name]}
end

def create_project
  create_example_project
  delete_project
  @project = FactoryGirl.create(:project, name: @example_project[:name])
end

def create_private_project
  create_example_project
  delete_project
  @project = FactoryGirl.create(:project, name: @example_project[:name], public: false)
end

def create_public_project
  create_example_project
  delete_project
  @project = FactoryGirl.create(:project, name: @example_project[:name], public: true)
end

def delete_project
  @project ||= Project.first conditions: {:name => @example_project[:name]}
  @project.destroy unless @project.nil?
end

### GIVEN ###
Given /^a public project exists$/ do
  create_public_project
end

Given /^a private project exists$/ do
  create_private_project
end

Given /^I am owner of a project$/ do
  create_project
  create_user_project
end

Given /^I am not the owner of a project$/ do
  create_project
  create_user_project
  @users_project.access_level = 1
  @users_project.save
end

When /^I look at the public list of projects$/ do
  visit '/projects'
end

When /^I go to the edit project page$/ do
  visit edit_user_users_project_path(@user, @users_project)
end

When /^I look at the project page$/ do
  visit project_path(@project)
end

When /^I change the project name$/ do
  fill_in "Name", :with => "newname"
  click_button "Update Settings"
end

Then /^I should see the new name$/ do
  page.should have_content @project[:name]
end

Then /^I should see the name of the project$/ do 
  page.should have_content @project[:name]
end

Then /^I should not see the name of the project$/ do 
  page.should_not have_content @project[:name]
end

Then /^I should see the edit project form$/ do 
  page.should have_content "Edit Project"
end

Then /^I should see an error page$/ do
end

