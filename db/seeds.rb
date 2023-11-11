require 'bcrypt'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

courses = [{:courseName => 'COMS 4152', :courseDescription => 'Engineering Software-as-a-Service'},
{:courseName => 'CSOR 4231', :courseDescription => 'Intro to Algorithms'},
{:courseName => 'TestClass', :courseDescription => 'Test Description'}]

users = [{:uni => "cheems", :password_digest => BCrypt::Password.create("password"), :name => "Cheems Jr." }];

entitlements = [{:uni => "cheems", :courseId => "COMS 4152", :role => "student", 
:created_at=> DateTime.new(2023,1,1), :updated_at=>DateTime.new(2023,1,1)}];

courses.each do |course|
	Course.create!(course)
end

users.each do |user|
  User.create user
end

entitlements.each do |entitlement|
  Entitlement.create(entitlement)
end
