Feature: Navigate site from project nav starting at the main page

Scenario: I can navigate to my user project page
Given I am logged in
And a project exists
When I navigate to the user project page
And I click on the project link
Then I should be directed to the user project page

Scenario: I can navigate to my project feature page
Given I am logged in
And a project exists
When I navigate to the user project page
And I click on the features link
Then I should be directed to the project feature page

Scenario: I can navigate to my project issues page
Given I am logged in
And a project exists
When I navigate to the user project page
And I click on the issues link
Then I should be directed to the project issues page

Scenario: I can navigate to my project notes page
Given I am logged in
And a project exists
When I navigate to the user project page
And I click on the notes link
Then I should be directed to the project notes page

Scenario: I can navigate to my settings page
Given I am logged in
And a project exists
When I navigate to the user project page
And I click on the settings link
Then I should be directed to the settings page
