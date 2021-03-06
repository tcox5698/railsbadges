Feature: As a user I want to log actions
  so that I have a history of what I have accomplished

  Background:
    Given application is initialized

  Scenario: As a user I can log an action and see it on my dashboard.
    Given I login as a normal user
    When I log an action called 'finished something'
    Then I visit the dashboard
    Then I see 'finished something' in my recent actions

