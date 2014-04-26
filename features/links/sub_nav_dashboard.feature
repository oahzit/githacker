Feature: Navigate site from dashboard nav
As a user of the site
I can click on the links in the navigation
And get to the intended site

Scenario: I can navigate to my projects page
Given I am logged in
When I click on the my projects link
Then I should be directed to my projects page

Scenario: I can navigate to all issues page
Given I am logged in
When I click on the active issues link
Then I should be directed to all issues page

Scenario: I can navigate to resources page
Given I am logged in
When I click on the resources link
Then I should be directed to the resources page

Scenario: I can navigate to support page
Given I am logged in
When I click on the support link
Then I should be directed to the support page