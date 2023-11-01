Feature: add office hour slots

  As a user of the application who is a TA
  I want to be able to create a new office hour slot

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni        | password        | name     |
  | testUni    | testPassword    | testName |

  Given the following courses exist:
  | id | courseName | courseDescription                 | 
  | 0  | COMS 4152  | Engineering Software-as-a-Service |
  | 1  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni        | courseId  | role   | 
  | testUni    | COMS 4152 | TA     |

Scenario: Login and navigating to new office hour creation page
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testName!"
  When I follow "Edit TA Office Hours"
  Then I should see "Hello, TA testName"

Scenario: Login and creating a new office hour slot
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Edit TA Office Hours"
  And I fill in "Class" with "COMS 4152"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hours were successfully added."

Scenario: Fill out and submit the office hour form with invalid data
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Edit TA Office Hours"
  And I fill in "Class" with ""
  And I click the "Create Calendar" button
  Then I should see "1 error prohibited this calendar from being saved:"
  And I should see "Class can't be blank"
