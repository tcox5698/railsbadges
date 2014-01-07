Feature: As a potential user
  I should see a landing page
  when I visit the application

Scenario: I see a landing page when I visit the application
  Given I have not logged in
  When I visit the application
  Then I see the text 'What can I do? What have I done? Track your skills with Merit Badges.'
