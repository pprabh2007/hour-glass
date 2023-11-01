require 'bcrypt'

Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
        User.create user
    end
end
  
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    expect(page.body.index(e1) < page.body.index(e2))
end