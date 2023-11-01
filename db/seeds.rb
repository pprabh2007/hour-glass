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

schedules = [{:courseId => 'COMS 4152', :startTime=> DateTime.new(2023, 1, 1, 13, 0), :endTime=> DateTime.new(2023, 1, 1, 14, 0)},
{:courseId => 'CSOR 4231', :startTime=> DateTime.new(2023, 1, 2, 14, 0), :endTime=> DateTime.new(2023, 1, 2, 15, 0)}]

users = [{:uni => "cheems", :password_digest => "password", :created_at=> DateTime.new(2023,1,1),
:updated_at => DateTime.new(2023,1,1), :name => "Cheems Jr." }];

entitlements = [{:uni => "cheems", :courseId => "COMS 4152", :role => "student", 
:created_at=> DateTime.new(2023,1,1), :updated_at=>DateTime.new(2023,1,1)}];

courses.each do |course|
	Course.create!(course)
  end

schedules.each do |schedule|
  Schedule.create!(schedule)
end

users.each do |user|
  User.create(user)
end

entitlements.each do |entitlement|
  Entitlement.create(entitlement)
end