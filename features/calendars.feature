Feature: view my calendar

  As a user of the application
  So that I can see my office hours times for my classes
  I want to open up a weekly schedule view of the office hours for my class

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni           | password        | name          | is_professor |
  | testStudent   | testPassword    | testStudent   | false        |
  | testTA        | testPassword    | testTA        | false        |
  | testProfessor | testPassword    | testProfessor | true         |

  Given the following courses exist:
  | courseName | courseDescription                 | 
  | COMS 4152  | Engineering Software-as-a-Service |
  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni            | courseName  | role   | 
  | testStudent    | COMS 4152   | Viewer |
  | testTA         | COMS 4152   | TA     |
  | testProfessor  | COMS 4152   | Prof   |
  | testProfessor  | CSOR 4231   | Prof   |

  Given the following calendars exist:
  | courseName | start_time          | end_time            | repeated_weeks | user_id |
  | COMS 4152  | 2023-10-31 08:00:00 | 2023-10-31 10:00:00 | 0              | 2       |
  | CSOR 4231  | 2023-10-31 11:00:00 | 2023-10-31 13:00:00 | 0              | 3       |

Scenario: Login as a student and see calendar items with my viewable classes
  When I go to the login page
  And  I fill in "Uni" with "testStudent"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  And  I go to the calendars page for day 29, month 10, year 2023
  Then I should see "COMS 4152"
  And  I should not see "CSOR 4231"
  And  I follow "Next Week"
  Then I should not see "COMS 4152"
  And  I should not see "CSOR 4231"
  And  I follow "Prev Week"
  Then I should see "COMS 4152"
  And  I should not see "CSOR 4231"

Scenario: Login as a student and press view schedule button to open up calendar page
  When I go to the login page
  And  I fill in "Uni" with "testStudent"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  And  I follow "View Schedule"
  Then I should see "Calendar"

Scenario: Login as a TA, make a calendar update, and the student can see the changes
  When I go to the login page
  And  I fill in "Uni" with "testTA"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  Then I should see "COMS 4152"
  And  I should see "2023-10-31 08:00:00"
  And  I should see "2023-10-31 10:00:00"
  And  I follow "Edit TA Office Hours"
  And  I follow "Delete" 
  Then I should see "Office hour was successfully deleted."
  When I go to the login page
  And  I fill in "Uni" with "testStudent"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  And  I go to the calendars page for day 29, month 10, year 2023
  Then I should not see "COMS 4152"

