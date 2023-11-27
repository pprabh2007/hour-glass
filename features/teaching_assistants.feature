Feature: add office hour slots

  As a user of the application who is a TA
  So that I can display my Office Hours schedule for my class
  I want to be able to create a new office hour slot

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni        | password        | name     | is_professor |
  | testUni    | testPassword    | testName | false        |

  Given the following courses exist:
  | courseName | courseDescription                 | 
  | COMS 4152  | Engineering Software-as-a-Service |
  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni        | courseName  | role   | 
  | testUni    | COMS 4152   | TA     |
  | testUni    | CSOR 4231   | TA     |

Scenario: Login and navigating to new office hour creation page
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testName"
  When I follow "Create New Office Hours"
  Then I should see "testName"

Scenario: Login and creating a single new office hour slot
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Create New Office Hours"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "04 PM" for the end-time
  And I fill in "Location" with "Zoom (Link TBA)"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hour was successfully added."

Scenario: Login and creating a recurring new office hour slot
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Create New Office Hours"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "04 PM" for the end-time
  And I fill in "Number of Repeated Weeks" with "2"
  And I fill in "Location" with "Zoom"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hours were successfully added."

Scenario: Login and attempt to setup an invalid office hour slot and get a warning message
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Create New Office Hours"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "02 PM" for the end-time
  And I fill in "Number of Repeated Weeks" with "2"
  And I fill in "Location" with "Zoom"
  And I click the "Create Calendar" button
  Then I should see "All calendar events must end on the same day and strictly after the start time"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "27", "04 PM" for the end-time
  And I fill in "Number of Repeated Weeks" with "2"
  And I click the "Create Calendar" button
  Then I should see "All calendar events must end on the same day and strictly after the start time"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "04 PM" for the end-time
  And I fill in "Number of Repeated Weeks" with "2"
  And I fill in "Location" with "Zoom"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hours were successfully added."

Scenario: Login, creating a single new office hour slot for 2 different classes, and filtering
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Create New Office Hours"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "04 PM" for the end-time
  And I fill in "Location" with "Zoom"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hour was successfully added."
  When I follow "Create New Office Hours"
  When I select "CSOR 4231" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "04 PM" for the end-time
  And I fill in "Location" with "Zoom"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hour was successfully added."
  When I follow "Edit Current Office Hours"
  Then I should see "COMS 4152"
  Then I should see "CSOR 4231"
  When I select "COMS 4152" from the course dropdown for filtering
  And I click the "Filter" button
  Then I should see "COMS 4152"
  And I should see "Edit"
  And I should see "Delete"
  Then I should not see the following in my results: "CSOR 4231"

Scenario: Login, creating a single new office hour slot, and updating it
  When I go to the login page
  And I fill in "Uni" with "testUni"
  And I fill in "Password" with "testPassword"
  And I press "Sign In!"
  When I follow "Create New Office Hours"
  When I select "COMS 4152" from the course dropdown menu
  When I select "2023", "November", "26", "03 PM" for the start-time
  When I select "2023", "November", "26", "04 PM" for the end-time
  And I fill in "Location" with "Zoom"
  And I click the "Create Calendar" button
  Then I should see a success message "Office hour was successfully added."
  When I follow "Edit Current Office Hours"
  When I follow "Edit"
  And I click the "Update Calendar" button
  Then I should see a success message "Office hour was successfully updated."