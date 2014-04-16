Feature: User Access
As a user of the website
I cannot access another users projects 

Scenario: Cannot access another users projects
Given I am logged in
When I go to view another users projects
Then I should see an authorization error

Scenario: Cannot access another users projects settings
Given I am logged in
And a project exists
When I go to view another users projects settings
Then I should see an authorization error
