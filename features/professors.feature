Feature: create a new class

  As a user of the application who is a professor
  I want to be able to create a new class and add TAs to it

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
  | testUni    | 0         | Professor |

Scenario: Login and navigating to new course creation page
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testName!"
  When I follow "Create a New Course"
  Then I should see "Hello, Professor testName!"

Scenario: Login and creating a new course
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  When I follow "Create a New Course"
  And  I fill in "Course Id" with "COMS 4444"
  And  I fill in "Course Name" with "Programming & Problem Solving"
  And  I fill in "Enter TA UNIs (comma seperated)" with "TA123,TA234"
  And  I press "Create a New Course"
  Then I should see "Successfully created new course 'COMS 4444:Programming & Problem Solving'."


  Scenario: Login and re-creating an already existing course
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  When I follow "Create a New Course"
  And  I fill in "Course Id" with "CSOR 4231"
  And  I fill in "Course Name" with "Introduction to Algorithms"
  And  I fill in "Enter TA UNIs (comma seperated)" with "TA123,TA234"
  And  I press "Create a New Course"
  Then I should see "Error: Course 'CSOR 4231' already exists."