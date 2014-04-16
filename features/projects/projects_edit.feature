Feature: Edit Projects
As a user of the site
I want to be able to edit projects
so that that I can update their fields

Scenario: Project has edit form
Given I exist as a user
And I am owner of a project
When I go to the edit project page
Then I should see the edit project form

Scenario: Can update the project name
Given I exist as a user
And I am owner of a project
When I go to the edit project page
And I change the project name
Then I should see the new name

Scenario: Can update the project website
Given I exist as a user
And I am owner of a project
When I go to the edit project page
And I change the project website
Then I should see the new website

Scenario: Cannot update the project website
Given I exist as a user
And I am not the owner of a project
When I go to the edit project page
Then I should not see the edit project form