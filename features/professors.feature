Feature: create a new class

  As a user of the application who is a professor
  So that I can have an office hour schedule for my class
  I want to be able to create a new class and add TAs to it

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni                 | password        | name              | is_professor |
  | testStudentUni      | testPassword    | testStudentName   | false        |
  | testProfessorUni    | testPassword    | testProfessorName | true         |

  Given the following courses exist:
  | courseName | courseDescription                 | 
  | COMS 4152  | Engineering Software-as-a-Service |
  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni                 | courseName  | role      | 
  | testProfessorUni    | COMS 4152 | Professor |

Scenario: Login as a professor and navigating to new course creation page
  When I go to the login page
  And  I fill in "Uni" with "testProfessorUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testProfessorName"
  When I follow "Create a New Course"
  Then I should see "testProfessorName"

Scenario: Login as a student and fail to navigate to new course creation page (only for professors)
  When I go to the login page
  And  I fill in "Uni" with "testStudentUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "testStudentName"
  And  I should not see "Create a New Course"
  When I go to the professors page manually
  Then I should see "testStudentName"
  And  I should see "You do not have permission to add new courses"

Scenario: Login as a professor and creating a new course
  When I go to the login page
  And  I fill in "Uni" with "testProfessorUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  When I follow "Create a New Course"
  And  I fill in "Course Name" with "COMS 4444"
  And  I fill in "Course Description" with "Programming & Problem Solving"
  And  I fill in "Enter TA UNIs (comma seperated)" with "TA123,TA234"
  And  I press "Create Course"
  Then I should see "Successfully created new course 'COMS 4444:Programming & Problem Solving'."
  Then I should see "COMS 4444"

Scenario: Login as a professor and re-creating an already existing course
  When I go to the login page
  And  I fill in "Uni" with "testProfessorUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  When I follow "Create a New Course"
  And  I fill in "Course Name" with "CSOR 4231"
  And  I fill in "Course Description" with "Introduction to Algorithms"
  And  I fill in "Enter TA UNIs (comma seperated)" with "TA123,TA234"
  And  I press "Create Course"
  Then I should see "Error: Course 'CSOR 4231' already exists."
