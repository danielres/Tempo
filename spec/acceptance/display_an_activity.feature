@display_an_activity
Feature: Display an activity

  Scenario: Displaying the activity timesheets
    Given an activity "swimming" that was practiced during 3 months
    When  I visit the activity page
    Then  I should see 3 timesheets