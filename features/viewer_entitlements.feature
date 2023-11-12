Feature: add a viewable class

  As a user of the application
  So that I can view the Office Hour schedule for a class
  I want to have a button that lets me add a class to my schedule

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni        | password        | name     | is_professor |
  | testUni    | testPassword    | testName | false        |

  Given the following courses exist:
  | id | courseName | courseDescription                 | 
  | 0  | COMS 4152  | Engineering Software-as-a-Service |
  | 1  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni        | courseId  | role   | 
  | testUni    | COMS 4152 | Viewer |


Scenario: Login and see my viewable classes
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testName!"
  And  I should see "Your Viewable Courses"
  And  I should see "COMS 4152"
  And  I should see "Engineering Software-as-a-Service"
  And  I should not see "CSOR 4231"
  And  I should not see "Intro to Algorithms"

  Scenario: Add entitlement for a new viewable class
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testName!"
  And  I should see "Your Viewable Courses"
  And  I should not see "CSOR 4231"
  And  I should not see "Intro to Algorithms"
  When I fill in "Course Name" with "CSOR 4231"
  And  I press "Add New Viewable Course"
  Then I should see "CSOR 4231"
  And I should see "Intro to Algorithms"
  And I should see "Added new class 'CSOR 4231' to schedule"

  Scenario: Cannot add same class multiple times
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testName!"
  And  I should see "Your Viewable Courses"
  And  I should see "COMS 4152"
  When I fill in "Course Name" with "COMS 4152"
  And  I press "Add New Viewable Course"
  And  I should see "You already have access to the inputted class."

  Scenario: Cannot input invalid class name
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  And  I fill in "Course Name" with "NOTACLASS"
  And  I press "Add New Viewable Course"
  Then I should see "Hello, testName!"
  And  I should see "No such class exists. Please input a valid class."
