@dashboard
Feature: Dashboard

  Scenario: Displaying the dashboard
    Given activities: "work, play, sleep"
    When I visit the main page
    Then I should see the dashboard with links to the activities: "work, play, sleep"
