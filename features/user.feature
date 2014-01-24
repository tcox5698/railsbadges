Feature: As a user
  I need an account
  So that I can provide information specific to myself

  Scenario: I can create an account and login
    Given email 'buckaroo@here.com' does not exist
    When I visit the login page
    Then I have the option to create a new account
    When I create an account with email 'buckaroo@here.com' and password 'Password7!'
    Then I receive an email confirmation at 'buckaroo@here.com'
    When I follow the link in the email confirmation sent to 'buckaroo@here.com'
    Then I can login with email 'buckaroo@here.com' and password 'Password7!'

  Scenario: I can logout so that no one has access to my account
    Given I am logged in
    Then the 'Login' link is not visible
    And the 'Logout' link is visible
    When I logout
    Then the 'Login' link is visible
    And the 'Logout' link is not visible

  Scenario: I can not see dashboard if I am not logged in
    Given I am not logged in
    When I visit the dashboard
    Then I am prompted to login

  Scenario: I can see the dashboard if I am logged in
    When I login as a normal user
    When I visit the dashboard
    Then I see the dashboard