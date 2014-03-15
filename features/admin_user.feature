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

  Scenario: When the default superuser configures someone else as a super user, the default
  superuser is disabled and logged out
    Given the following users exist
      | email         | roles | password |
      | bob@smith.com | user  | passw    |
    And I log in as superuser
    When I give user 'bob@smith.com' the role of 'administrator'
    Then the application tells me 'Logged out superuser since you updated a user. Login as a real person now.'
    When I visit the dashboard
    Then I am prompted to login

  Scenario: As an administrator I can change a user's roles.
    Given the following users exist
      | email           | roles         | password |
      | bob@smith.com   | user          | passw    |
      | admin@smith.com | administrator | passw    |
      | super@smith.com | superuser     | passw    |
    When I login as 'admin@smith.com' with password 'passw'
    And I give user 'bob@smith.com' the role of 'administrator'
    Then I can view a list of users containing the following users
      | email                     | roles         |
      | superuser@meritbadges.com | superuser     |
      | bob@smith.com             | administrator |
      | admin@smith.com           | administrator |
      | super@smith.com           | superuser     |

  Scenario: As an administrator I can view a list of users.
    Given the following users exist
      | email           | roles               | password |
      | bob@smith.com   | user                | passw    |
      | nancy@jones.com | user, administrator | passw2   |
      | super@smith.com | superuser           | passw    |
    When I visit the login page
    When I can login with email 'nancy@jones.com' and password 'passw2'
    Then I can view a list of users containing the following users
      | email                     | roles               |
      | superuser@meritbadges.com | superuser           |
      | bob@smith.com             | user                |
      | nancy@jones.com           | user, administrator |
      | super@smith.com           | superuser           |

  Scenario: As an administrator I can disable a user.
    Given the following users exist
      | email           | roles               | password |
      | bob@smith.com   | user                | passw    |
      | nancy@jones.com | user, administrator | passw2   |
      | super@smith.com | superuser           | passw    |
    And I visit the login page
    Then I can login with email 'bob@smith.com' and password 'passw'
    When I logout
    And I login as 'nancy@jones.com' with password 'passw2'
    Then I disable user 'bob@smith.com'
    When I logout
    And I login as 'bob@smith.com' with password 'passw'
    Then the application tells me 'Your account has been disabled. Please email tcox56_98@yahoo.com and hope for the best.'
    And I visit the dashboard
    Then I am prompted to login

  Scenario: As an administrator I can enable a user.
    Given the following users exist
      | email           | roles               | password | disabled |
      | bob@smith.com   | user                | passw    | true     |
      | nancy@jones.com | user, administrator | passw2   |          |
      | super@smith.com | superuser           | passw    |          |
    And I login as 'nancy@jones.com' with password 'passw2'
    Then I enable user 'bob@smith.com'
    When I logout
    And I visit the login page
    Then I can login with email 'bob@smith.com' and password 'passw'

  Scenario: As a user I can not edit my own roles.
    Given the following users exist
      | email           | roles     | password |
      | bob@smith.com   | user      | passw    |
      | super@smith.com | superuser | passw    |
    And I login as 'bob@smith.com' with password 'passw'
    And I give user 'bob@smith.com' the role of 'administrator'
    Then I can view a list of users containing the following users
      | email                     | roles     |
      | bob@smith.com             | user      |
