When /^I navigate to the user project page$/ do
    visit user_users_project_path(@user, @users_project)
end

When /^I navigate to the features page$/ do
    visit project_features_path(@project)
end

When /^I navigate to the issues page$/ do
    visit project_issues_path(@project)
end

When /^I navigate to the notes page$/ do
    visit project_notes_path(@project)
end

When /^I navigate to the settings page$/ do
    visit edit_user_users_project_path(@user, @users_project)
end

When /^I click on the my projects link$/ do
      click_link "My Projects"
end

When /^I click on the active issues link$/ do
    click_link "Active Issues"
end

When /^I click on the resources link$/ do
    click_link "Resources"
end

When /^I click on the support link$/ do
    click_link "Support"
end

When /^I click on the project link$/ do
    click_link "Project"
end

When /^I click on the features link$/ do
    click_link "Features"
end

When /^I click on the issues link$/ do
    click_link "Issues"
end

When /^I click on the notes link$/ do
    click_link "Notes"
end

When /^I click on the settings link$/ do
    click_link "Settings"
end

Then /^I should be directed to my projects page$/ do
    page.should have_content "My Projects"
end

Then /^I should be directed to all issues page$/ do
   page.should have_content "There are no issues for project you are following."
end

Then /^I should be directed to the resources page$/ do
    page.should have_content "Here are some basic resources we have collected to help you get started!"
end

Then /^I should be directed to the support page$/ do
      page.should have_content "Documentation Overview"
end

Then /^I should be directed to the user project page$/ do
      page.should have_content "Created on"
      page.should have_content "Owned by"
end

Then /^I should be directed to the project feature page$/ do
      page.should have_content "Your files are presently stored off-site"
end

Then /^I should be directed to the project issues page$/ do
      page.should have_content "There are no open issues for this project."
end

Then /^I should be directed to the project notes page$/ do
      page.should have_content "There are no notes for this project."
end 

Then /^I should be directed to the settings page$/ do
      page.should have_content "Edit Project Settings"
end 


