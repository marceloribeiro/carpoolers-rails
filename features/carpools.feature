Feature: Carpools

  Scenario: Browse Carpools
    Given I am on the home page
    And I have an existing account
    And there is a chapter for 'Mountain House, CA'
    And the following carpools exist:
      | chapter_name        | frequency   | carpool_date    | seats_available | start_location                        | end_location                                  | start_time  | end_time  |
      | Mountain House, CA  | daily       |                 | 1               | 3010 W Grant Line Rd, Tracy CA 95304  | Dublin/Pleasanton Bart Station, Dublin CA     | 8:00 AM     | 8:40 AM   |
      | Mountain House, CA  | once        | 2018-09-30      | 2               | 6690 Amador Plaza Rd, Dublin CA 94568 | 3010 W Grant Line Rd, Tracy CA 95304          | 4:00 PM     | 4:50 PM   |
    When I click 'Chapters'
    Then I should see a chapter for 'Mountain House, CA'
    When I click 'Mountain House, CA'
    Then I should see '3010 W Grant Line Rd, Tracy CA 95304'
    And I should see '6690 Amador Plaza Rd, Dublin CA 94568'
    When I click '3010 W Grant Line Rd, Tracy CA 95304'
    And I fill in the log in form
    And I press 'Log in'
    And I click 'Request to Join'
    Then I should have joined a carpool
    And my joined carpool status should be 'requested'
    And my 'joined' carpool 'start' location should be '3010 W Grant Line Rd, Tracy CA 95304'
    And my 'joined' carpool 'end' location should be 'Dublin/Pleasanton Bart Station, Dublin CA'

  Scenario: Create a Carpool
    Given I am on the home page
    And I have an existing account
    And there is a chapter for 'Mountain House, CA'
    When I click 'Chapters'
    Then I should see a chapter for 'Mountain House, CA'
    When I click 'Mountain House, CA'
    And I click 'Offer to Carpooling in Mountain House, CA'
    And I fill in the log in form
    And I press 'Log in'
    And I select 'once' from 'Frequency'
    And I select '2 days from now' as the date for 'Carpool date'
    And I fill in 'Seats available' with '2'
    And I fill in 'Start location' with '3010 W Grant Line Rd, Tracy CA 95304'
    And I fill in 'End location' with 'Dublin/Pleasanton Bart Station, Dublin CA'
    And I fill in 'Start time' with '8:00 AM'
    And I fill in 'End time' with '8:45 AM'
    And I press 'Submit'
    Then I should have created a carpool
    And my 'created' carpool 'start' location should be '3010 W Grant Line Rd, Tracy CA 95304'
    And my 'created' carpool 'end' location should be 'Dublin/Pleasanton Bart Station, Dublin CA'

  Scenario: Managing Carpools
    Given I am on the home page
    And I have an existing account
    And there is a chapter for 'Mountain House, CA'
    And I created the following carpools:
      | chapter_name        | frequency   | carpool_date    | seats_available | start_location                        | end_location                                  | start_time  | end_time  |
      | Mountain House, CA  | daily       |                 | 1               | 3010 W Grant Line Rd, Tracy CA 95304  | Dublin/Pleasanton Bart Station, Dublin CA     | 8:00 AM     | 8:40 AM   |
      | Mountain House, CA  | once        | 2018-09-30      | 2               | 6690 Amador Plaza Rd, Dublin CA 94568 | 3010 W Grant Line Rd, Tracy CA 95304          | 4:00 PM     | 4:50 PM   |
    And my carpool to 'Dublin/Pleasanton Bart Station, Dublin CA' has a request to join from 'Jane Doe'
    When I click 'Sign In'
    And I fill in the log in form
    And I press 'Log in'
    Then I should see 'My Carpools'
    And I should see '3010 W Grant Line Rd, Tracy CA 95304'
    And I should see '6690 Amador Plaza Rd, Dublin CA 94568'
    When I click '3010 W Grant Line Rd, Tracy CA 95304'
    Then I should see 'Jane Doe'
    When I click 'Approve'
    Then 'Jane Doe' carpool request should be approved
