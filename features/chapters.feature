Feature: Chapters

  Scenario: Browse Chapters
    Given I am on the home page
    And there is a chapter for 'Mountain House, CA'
    When I click 'Chapters'
    Then I should see a chapter for 'Mountain House, CA'

  Scenario: Create a new chapter
    Given I have an existing account
    And I am on the home page
    When I click 'Chapters'
    And I click 'Submit Your Chapter'
    Then I should see 'Log in'
    When I fill in the log in form
    And I press 'Log in'
    Then I should be logged in
    And I should be on the 'new chapter' page
    When I fill in the chapter form
    And I press 'Submit'
    Then I should be on the 'chapters' page
    And I should see my chapter
