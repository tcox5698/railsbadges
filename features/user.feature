Feature: As a user
  I need an account
  So that I can provide information specific to myself

  Scenario: I can create an account and login
    Given email 'tom@here.com' does not exist
    When I try to login
    Then I have the option to create a new account
    When I create an account with email 'tom@here.com' and password 'Password7!'
    Then I receive an email confirmation at 'tom@here.com'
    When I follow the link in the email confirmation sent to 'tom@here.com'
    Then I can login with email 'tom@here.com' and password 'Password7!'

  Scenario: I can logout so that no one has access to my account
    Given I am logged in
    When I try to login
    Then the application tells me I am already logged in
    When I logout
    Then I try to login
    Then I see the login page