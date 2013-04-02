Feature: Display an activity

  Scenario: Displaying the activity timesheet
    Given an activity "swimming" with some facts
    When  I visit the activity page
    Then  I should see a timesheet for "swimming" with the facts