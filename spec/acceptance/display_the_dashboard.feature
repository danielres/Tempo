Feature: Display the dashboard

  Scenario: Displaying the dashboard
    Given activities: "work, play, sleep"
    When I visit the main page
    Then I should see the dashboard
    And  I should see the activities: "work, play, sleep"
