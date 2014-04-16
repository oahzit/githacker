Feature: Create Projects
As a user of the site
I want to be able to create projects
so that that I can do interesting work

Scenario: Visitors cannot create projects
Given I exist as a visitor
When I go to the new project page
Then I should see an error

Scenario: Can create project from dashboard
Given I exist as a user
When I go to the root page
Then I should see the new project button

Scenario: Can create project from list
Given I exist as a user
When I go to the users project list page
Then I should see the new project button

Scenario: Can create a new project
Given I exist as a user
When I go to the new project page
And I create a new project
Then I should see the project in a list
