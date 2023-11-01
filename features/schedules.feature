Feature: view my schedule

  As a user of the application
  So that I can view my upcoming schedule for the selected classes
  I want to have a button that shows me my schedule

Background: users, courses, and entitlements in the database

  Given the following users exist:
  | uni        | password_digest        | name     |
  | testUni    | testPassword    | testName |

  Given the following courses exist:
  | id | courseName | courseDescription                 | 
  | 0  | COMS 4152  | Engineering Software-as-a-Service |
  | 1  | CSOR 4231  | Intro to Algorithms               |

  Given the following entitlements exist:
  | uni        | courseId  | role   | 
  | testUni    | COMS 4152 | Viewer |

  Given the following schedules exist:
  | courseId   | startTime           | endTime             |
  | COMS 4152  | 2023-10-31 08:00:00 | 2023-10-31 10:00:00 |
  | CSOR 4231  | 2023-10-31 11:00:00 | 2023-10-31 13:00:00 |

Scenario: Login and see my schedule
  When I go to the login page
  And  I fill in "Uni" with "testUni"
  And  I fill in "Password" with "testPassword"
  And  I press "Sign In!"
  And  I follow "View Schedule"
  Then I should see "COMS 4152"
  And I should not see "CSOR 4231"
