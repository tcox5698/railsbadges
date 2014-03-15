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

  Scenario: When there are actions from multiple users, I only see my own actions
    Given user 'x@y.com' with password 'password' exists
    And I login as 'x@y.com' with password 'password'
    And I log the following actions
      | name |
      | x1   |
      | x2   |
      | x3   |
    And I logout
    Given user 'a@b.com' with password 'password' exists
    And I login as 'a@b.com' with password 'password'
    And I log the following actions
      | name |
      | a1   |
      | a2   |
      | a3   |
    When I visit the dashboard
    Then I should see these and only these actions in this order
      | name |
      | a3   |
      | a2   |
      | a1   |
    When I logout
    And I login as 'x@y.com' with password 'password'
    When I visit the dashboard
    Then I should see these and only these actions in this order
      | name |
      | x3   |
      | x2   |
      | x1   |