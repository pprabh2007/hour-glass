require 'bcrypt'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

courses = [{:courseName => 'CSOR 4231', :courseDescription => 'Intro to Algorithms'},
{:courseName => 'TestClass', :courseDescription => 'Test Description'}]

users = [
  {:id => 1, :uni => "testStudent", :password_digest => BCrypt::Password.create("password"), :name => "testStudent", :is_professor => false},
  {:id => 2, :uni => "testProfessor", :password_digest => BCrypt::Password.create("password"), :name => "testProfessor", :is_professor => true},
  {:id => 3, :uni => "testTA", :password_digest => BCrypt::Password.create("password"), :name => "testTA", :is_professor => false},
  {:id => 4, :uni => "testProfessor2", :password_digest => BCrypt::Password.create("password"), :name => "testProfessor2", :is_professor => true}
]

entitlements = [
  {:uni => "testStudent", :courseName => "CSOR 4231", :role => "Viewer", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "testProfessor", :courseName => "CSOR 4231", :role => "Prof", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "testProfessor2", :courseName => "TestClass", :role => "Prof", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "testTA", :courseName => "CSOR 4231", :role => "TA", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)}
]


taCalendars = [
  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 15, 14), 
  end_time: DateTime.new(2023, 11, 15, 14) + 2.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 17, 17), 
  end_time: DateTime.new(2023, 11, 17, 17) + 1.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 22, 14), 
  end_time: DateTime.new(2023, 11, 22, 14) + 2.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 24, 17), 
  end_time: DateTime.new(2023, 11, 24, 17) + 1.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 29, 14), 
  end_time: DateTime.new(2023, 11, 29, 14) + 2.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 1, 17), 
  end_time: DateTime.new(2023, 12, 1, 17) + 1.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 6, 14), 
  end_time: DateTime.new(2023, 12, 6, 14) + 2.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 8, 17), 
  end_time: DateTime.new(2023, 12, 8, 17) + 1.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 13, 14), 
  end_time: DateTime.new(2023, 12, 13, 14) + 2.hour, repeated_weeks: 4, user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 15, 17), 
  end_time: DateTime.new(2023, 12, 15, 17) + 1.hour, repeated_weeks: 4, user_id: 3 }
]

profCalendars = [
  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 13, 12), 
  end_time: DateTime.new(2023, 11, 13, 12) + 2.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 14, 9), 
  end_time: DateTime.new(2023, 11, 14, 9) + 1.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 20, 12), 
  end_time: DateTime.new(2023, 11, 20, 12) + 2.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 21, 9), 
  end_time: DateTime.new(2023, 11, 21, 9) + 1.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 27, 12), 
  end_time: DateTime.new(2023, 11, 27, 12) + 2.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 28, 9), 
  end_time: DateTime.new(2023, 11, 28, 9) + 1.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 4, 12), 
  end_time: DateTime.new(2023, 12, 4, 12) + 2.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 5, 9), 
  end_time: DateTime.new(2023, 12, 5, 9) + 1.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 11, 12), 
  end_time: DateTime.new(2023, 12, 11, 12) + 2.hour, repeated_weeks: 4, user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 12, 9), 
  end_time: DateTime.new(2023, 12, 12, 9) + 1.hour, repeated_weeks: 4, user_id: 2 }
]

users.each do |user|
  User.create user
end

courses.each do |course|
	Course.create!(course)
end

entitlements.each do |entitlement|
  Entitlement.create(entitlement)
end

taCalendars.each do |calendar|
  Calendar.create(calendar)
end

profCalendars.each do |calendar|
  Calendar.create(calendar)
end