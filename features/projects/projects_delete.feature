Feature: Create Projects
As a user of the site
I want to be able to delete projects
and I can only do so as the owner

Scenario: Owner of the project can delete
Given I am logged in
And I am owner of a project
When I go to delete a project
Then I should see a success message

Scenario: If not owner of the project cannot delete 
Given I am logged in
And I am not the owner of a project
When I go to delete a project
Then I should see an unsuccessful message

Scenario: Owner can delete project from project page
Given I am logged in
And I am owner of a project
When I go to the internal projects page
Then I should see a delete project button

Scenario: If not owner cannot delete project from project page
Given I am logged in
And I am not the owner of a project
When I go to the internal projects page
Then I should not see a delete project button

Scenario: Owner can delete project from project list
Given I am logged in
And I am owner of a project
When I go to the users projects page
Then I should see a delete project button

Scenario: If not owner cannot delete project from project list
Given I am logged in
And I am not the owner of a project
When I go to the users projects page
Then I should not see a delete project button
