Feature: Display total hours worked by month
  Background:
    Given I have worked last month

  Scenario: Displaying the total hours worked last month
    When I request informations for last month
    Then I should see the total hours I worked