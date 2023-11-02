**Group Member Names & UNI’s:**

**Member 1 Name: Harpreet Multani (hkm2125)
Member 2 Name: Prabhpreet Sodhi (pss2161)
Member 3 Name: Shivansh Srivastava (ss5945)
Member 4 Name: Atharv Vanarase (avv2116)**

**Heroku Link:** https://stark-spire-91731-04d281d9e62f.herokuapp.com/ 

**Github Link:** [pprabh2007/hour-glass (github.com)](https://github.com/pprabh2007/hour-glass)

**Code coverage (in the repo in the coverage/index.html directory):** 100%

**To run our code, we used the following commands in our root project directory:**

bundle install --without production

bundle exec rake db:drop

bundle exec rake db:migrate RAILS_ENV=test

bundle exec rackup --port 3000

**To run our test code, we used the following commands in our root project directory:**

bundle exec rake db:drop

bundle exec rake db:migrate RAILS_ENV=test

bundle exec rake cucumber

bundle exec rake spec

**How to navigate the app:**

Once you open up the app, you will be prompted to create an account using your uni, name, and password.
Once you are on the profile page you will now see a few different sections, at the very top you’ll be able to view courses that you have added to your schedule (currently empty since you haven’t created any). Then you will see a button to add TA office hours and at the bottom to create a new course.

First, you want to create a new course, by entering in the course id (e.g. coms 0000), course name, and a list of TA UNIs (can be any uni for now). You should now see the class listed at the top for courses you have created. If you try to create a new course using the exact same course id again, you will run into an error. You can then return to the profile page, and create a TA office hours slot.

For adding a new office hour slot, click on “Edit TA Office Hours” to be redirected to the new office hour page. (For the purposes of iteration 1, every account is automatically given these TA privileges.) Fill in the Class with an appropriate class name, and modify the start and end times as necessary. When finished, click on the “Create Calendar” button. If the slot was created successfully, you should find yourself back on the user profile page and see an alert that says, "Office hours were successfully added." In addition, the newly added slot should be visible under “Your Office Hour Slots”.

However, if you try to add an office hour slot without a name, the slot will not be created. If you try to click on “Create Calendar” without providing a class name, you will remain on the new office hour page and see the following error: "1 error prohibited this calendar from being saved: Class can't be blank."


Now once you are on the profile page, in order to view the current TA schedules, you can click on view schedule. This opens up a page where you are able to view all the current TA office hours for any classes you have added.

Then, return to the profile page by clicking back and sign out. On the login screen, sign up as a new account with a new uni, new name, and new password. Then, you should see a profile for this new user (the name at the top should be the one you just inputted). Type the course name that you just created into the course name text field under “View a new course on your schedule”. If you input the course correctly, you should see that course under “Your Viewable Courses”. If you click on the view schedule again, you should see the Office Hours that you inputted as the previous user. Hit back to return to your profile page. If you click on “Create a New Course”, you will be brought to a new page that shows the courses that you own. There should not be any owned courses for this user.

*for now all users have the ta access and professor access privileges in order to make testing across functionalities for this iteration much simpler and faster*
