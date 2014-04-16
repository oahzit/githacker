Feature: User Access
  As a user of the website
  I cannot access another users projects 

    Scenario: Cannot access another users projects
      Given I exist as a visitor
      When I go to view another users projects
      Then I should see an authorization error
