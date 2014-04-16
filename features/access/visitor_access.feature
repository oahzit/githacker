Feature: Visitor Access
  As a visitor to the website
  I can access a list of projects 
  I can access a list of issues
  I can access a public project page
  I can access a public user page

  I cannot access a users projects (complete)

    Scenario: Cannot access users projects
      Given I exist as a visitor
      When I go to view another users projects
      Then I should see an authentication error
