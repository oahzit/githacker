def create_user_project
	@users_project = FactoryGirl.create(:users_project, user_id: @user.id, project_id: @project.id)
end

When /^I go to view another users projects$/ do
	@second_user = FactoryGirl.create(:user, :email => "test@test.com") if !@second_user.present?
	visit user_users_projects_path(@second_user)
	@second_user.destroy
end

When /^I go to view another users projects settings$/ do
	@second_user = FactoryGirl.create(:user, :email => "test@test.com") if !@second_user.present?
	@second_users_project = FactoryGirl.create(:users_project, user_id: @second_user.id, project_id: @project.id)
	visit edit_user_users_project_path(@second_user, @second_users_project)
	@second_user.destroy
end

Then /^I should see an authentication error$/ do
	page.should have_content "You need to sign in or sign up before continuing"
end

Then /^I should see an authorization error$/ do
	page.should have_content "Unauthorized access"
end

Then /^I should see the users projects page$/ do
	page.should have_content "My Projects" 
end