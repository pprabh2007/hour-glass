Feature: add a viewable class

  As a user of the application
  So that I can view the Office Hour schedule for a class
  I want to have a button that lets me add a class to my schedule

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni        | password        | name     | is_professor |
  | testUni    | testPassword    | testName | false        |

  Given the following courses exist:
  | courseName | courseDescription                 | 
  | COMS 4152  | Engineering Software-as-a-Service |
  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni        | courseName | role   | 
  | testUni    | COMS 4152  | TA     |


Scenario: Login and see my viewable classes
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testName"
  And  I should see "Your Viewable Courses"
  And  I should see "COMS 4152" before "Your Office Hour Slots"
  And  I should see "Engineering Software-as-a-Service" before "Your Office Hour Slots"
  And  I should not see "CSOR 4231" before "Your Office Hour Slots"
  And  I should not see "Intro to Algorithms" before "Your Office Hour Slots"

  Scenario: Add entitlement for a new viewable class
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testName"
  And  I should see "Your Viewable Courses"
  And  I should not see "CSOR 4231" before "Your Office Hour Slots"
  And  I should not see "Intro to Algorithms" before "Your Office Hour Slots"
  When I select "CSOR 4231" from "Course Name"
  And  I press "Add New Viewable Course"
  Then I should see "CSOR 4231" before "Your Office Hour Slots"
  And  I should see "Intro to Algorithms" before "Your Office Hour Slots"
  And  I should see "Added new class 'CSOR 4231' to schedule"

  Scenario: Cannot add same class multiple times
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testName"
  And  I should see "Your Viewable Courses"
  And  I should see "COMS 4152" before "Your Office Hour Slots"
  When I select "COMS 4152" from "Course Name"
  And  I press "Add New Viewable Course"
  And  I should see "You already have access to the inputted class."

  Scenario: Cannot add empty class name
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testName"
  And  I should see "Your Viewable Courses"
  And  I should see "COMS 4152" before "Your Office Hour Slots"
  When I press "Add New Viewable Course"
  And  I should see "Please choose a valid class to start viewing."