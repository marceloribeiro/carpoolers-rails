Feature: User Account

  Scenario: Sign Up
    Given I am on the home page
    When I click 'Sign In'
    And I click 'Sign up'
    And I fill in the signup form
    And I press 'Sign up'
    Then I should be logged in

  Scenario: Sign in
    Given I have an existing account
    And I am on the home page
    When I click 'Sign In'
    And I fill in the log in form
    And I press 'Log in'
    Then I should be logged in
