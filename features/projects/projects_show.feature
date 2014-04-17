Feature: Show Users
As a visitor to the website
I want to see a list of public projects
so I can know if the site has projects

Scenario: Viewing projects as a visitor
Given I exist as a user
And a public project exists
When I look at the public list of projects
Then I should see the name of the project

Scenario: Projects visible does not contain private projects
Given I exist as a user
And a private project exists
When I look at the public list of projects
Then I should not see the name of the project

Scenario: Visitor can view public project page
Given I exist as a user
And a public project exists
When I look at the project page
Then I should see the name of the project

Scenario: Visitor cannot view private project page
Given I exist as a user
And a private project exists
When I look at the project page
Then I should not see the name of the project
