def create_user_project
  @users_project = FactoryGirl.create(:users_project, user_id: @user.id, project_id: @project.id)
end

When /^I go to view another users projects$/ do
	create_user
	visit user_users_projects_path(@user)
end

Then /^I should see an authorization error$/ do
  page.should have_content "You need to sign in or sign up before continuing"
end

Then /^I should see the users projects page$/ do
  page.should have_content "My Projects" 
end