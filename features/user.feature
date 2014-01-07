Feature: As a user
  I need an account
  So that I can provide information specific to myself

  Scenario: I can create an account and login
    Given username 'tom@here.com' does not exist
    When I try to login
    Then I have the option to create a new account
    When I create an account with username 'tom@here.com' and password 'Password7!'
    Then I receive an email confirmation
    When I follow the link in the email confirmation
    Then I can login with username 'tom@here.com' and password 'Password7!'