Feature: As a potential user
  I should see a landing page
  when I visit the application

  Background:
    Given application is initialized

  Scenario: I see a landing page when I visit the application
    Given I have not logged in
    When I visit the application
  Then I see the text 'What can I do? What have I done? Track your skills with Merit Badges.'

  Scenario: I see my 10 most recent actions
    Given I login as a normal user
    And I log the following actions
      | name     |
      | action1  |
      | action2  |
      | action3  |
      | action4  |
      | action5  |
      | action6  |
      | action7  |
      | action8  |
      | action9  |
      | action10 |
      | action11 |
    When I visit the dashboard
    Then I should see these and only these actions in this order
      | name     |
      | action11 |
      | action10 |
      | action9  |
      | action8  |
      | action7  |
      | action6  |
      | action5  |
      | action4  |
      | action3  |
      | action2  |
