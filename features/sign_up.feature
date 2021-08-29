Feature: User Account

  Scenario: Sign Up
    Given I am on the home page
    When I click 'Sign In'
    And I click 'Sign up'
    And I fill in the signup form
    And I press 'Sign up'
    Then I should be logged in
