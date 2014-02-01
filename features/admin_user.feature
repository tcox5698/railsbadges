Feature: As a system administrator
  I can manage all the users
  So that I can help them or prevent them from doing harm

  Scenario: When no one has logged in as super user then no one else can log in.
    Given no one has logged in as superuser
    When I login as a normal user
    Then the application tells me 'MeritBadges is not initialized. Please login as superuser and configure another user as superuser.'
    And I should not be logged in

  Scenario: When someone logs in as super user they are prompted to specify a different user as admin
    Given no one has logged in as superuser
    And the following users exist
      | email         | roles | password |
      | bob@smith.com | user  | passw    |
    When I log in as superuser
    Then I am prompted to configure a user with administrator role

  @javascript
  Scenario: When the default superuser configures someone else as a super user, the default
    superuser is disabled and logged out
    Given the following users exist
      | email         | roles | password |
      | bob@smith.com | user  | passw    |
    And I log in as superuser
    When I give user 'bob@smith.com' the role of 'administrator'
    Then I am prompted to login
    Then the application tells me 'The super user has now been disabled.  Please log in as a regular user.'

  Scenario: As an administrator I can change a user's roles.
    Given the following users exist
      | email         | roles | password |
      | bob@smith.com | user  | passw    |
    When I give user 'bob@smith.com' the role of 'administrator'
    Then I can view a list of users containing the following users
      | email                     | roles               |
      | superuser@meritbadges.com | superuser           |
      | bob@smith.com             | user, administrator |

  Scenario: As an administrator I can view a list of users.
    Given the following users exist
      | email           | roles               | password |
      | bob@smith.com   | user                | passw    |
      | nancy@jones.com | user, administrator | passw2   |
    When I visit the login page
    When I can login with email 'nancy@jones.com' and password 'passw2'
    Then I can view a list of users containing the following users
      | email                     | roles               |
      | superuser@meritbadges.com | superuser           |
      | bob@smith.com             | user                |
      | nancy@jones.com           | user, administrator |

  Scenario: As an administrator I can disable a user.
    Given pending

  Scenario: As an administrator I can unlock a user.
    Given pending

  Scenario: As a user I can not edit my roles.
    Given pending