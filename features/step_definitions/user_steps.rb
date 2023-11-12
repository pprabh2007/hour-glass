require 'bcrypt'

Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
        user['password_digest'] = BCrypt::Password.create(user['password'])
        User.create user
    end
end
