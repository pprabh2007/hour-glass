Feature: login as a specific user

  As a user of the application
  So that I can search for the Office Hours for my own classes
  I want to have an account to log in with and a personalized profile page

Background: users in database

  Given the following users exist:
  | uni                 | password        | name              | is_professor |
  | testStudentUni      | testPassword    | testStudentName   | false        |
  | testProfessorUni    | diffPassword    | testProfessorName | true         |

Scenario: Login as a student, see personalized profile page, and log out
  When I go to the login page
  And  I fill in "Uni" with "testStudentUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testStudentName!"
  And I should not see "Create a New Course"
  When I follow "Sign out"
  Then I should see "Log In"

Scenario: Login as a professor, see personalized profile page, and log out
  When I go to the login page
  And  I fill in "Uni" with "testProfessorUni"
  And  I fill in "Password" with "diffPassword"
  And  I press "Sign In!"
  Then I should see "Hello, testProfessorName!"
  And I should see "Create a New Course"
  When I follow "Sign out"
  Then I should see "Log In"

Scenario: Sign up for a new account, sign out, and relogin as myself
  When I go to the login page
  And  I fill in "New Uni" with "differentUni"
  And  I fill in "Name" with "differentName"
  And  I fill in "New Password" with "differentPassword"
  And  I press "Sign Up!"
  Then I should see "Hello, differentName!"
  When I follow "Sign out"
  Then I should see "Log In"
  And I should see "You have successfully logged out."
  When I fill in "Uni" with "differentUni"
  And  I fill in "Password" with "differentPassword"
  And  I press "Sign In!"
  Then I should see "Hello, differentName!"

Scenario: Invalid credentials should remain on login screen with a warning
  When I go to the login page
  And  I fill in "Uni" with "testStudentUni"
  And  I fill in "Password" with "nonexistentPassword"
  And  I press "Sign In!"
  Then I should see "Log In"
  And  I should see "Invalid login. Please try again."

  
Scenario: Cannot create two accounts with the same uni
  When I go to the login page
  And  I fill in "New Uni" with "testStudentUni"
  And  I fill in "Name" with "testStudentName"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign Up!"
  Then I should see "Log In"
  And  I should see "Inputted UNI already has an account. Please log in instead."
