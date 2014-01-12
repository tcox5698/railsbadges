Feature: As a system administrator
  I can manage all the users
  So that I can help them or prevent them from doing harm

  Scenario: When no one has logged in as super user then no one else can log in.
    Given no one has logged in as super user
    When I visit the login page
    Then I see the message 'Merit Badges has not been initialized.  Please initialize the system as super user.'
    When I try to login with email 'bob@smith.com' and password 'passw'
    Then I see the message 'Merit Badges has not been initialized.  Please initialize the system as super user.'

  Scenario: When someone logs in as super user they are prompted to specify a different user as admin
  and the super user is disabled.
    Given no one has logged in as super user
    When I log in as super user
    Then I am prompted to create a user with administrator role
    When I create a user with administrator role
    Then I see the message 'The super user has now been disabled.  Please log in as a regular user.'

  Scenario: As an administrator I can view a list of users.
    Given the following users exist
      | email           | roles               | password |
      | bob@smith.com   | user                | passw    |
      | nancy@jones.com | user, administrator | passw2   |
    When I can login with email 'nancy@jones.com' and password 'passw2'
    Then I can view a list of users containing the following users
      | email           | roles               |
      | bob@smith.com   | user                |
      | nancy@jones.com | user, administrator |

  Scenario: As an administrator I can disable a user.

  Scenario: As an administrator I can unlock a user.