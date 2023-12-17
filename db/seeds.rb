require 'bcrypt'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

courses = [{:courseName => 'CSOR 4231', :courseDescription => 'Intro to Algorithms'},
{:courseName => 'COMS 4771', :courseDescription => 'Machine Learning'}]

users = [
  {:uni => "avv2116", :password_digest => BCrypt::Password.create("password"), :name => "Atharv Vanarase", :is_professor => false},
  {:uni => "jy2324", :password_digest => BCrypt::Password.create("password"), :name => "Junfeng Yang", :is_professor => true},
  {:uni => "yt2781", :password_digest => BCrypt::Password.create("password"), :name => "Yun-Yun Tsai", :is_professor => false},
  {:uni => "testStudent", :password_digest => BCrypt::Password.create("password"), :name => "testStudent", :is_professor => false},
  {:uni => "testProfessor", :password_digest => BCrypt::Password.create("password"), :name => "testProfessor", :is_professor => true},
  {:uni => "testTA", :password_digest => BCrypt::Password.create("password"), :name => "testTA", :is_professor => false},
]

entitlements = [
  {:uni => "avv2116", :courseName => "CSOR 4231", :role => "Viewer", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "jy2324", :courseName => "CSOR 4231", :role => "Prof", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "yt2781", :courseName => "CSOR 4231", :role => "TA", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

   {:uni => "testStudent", :courseName => "COMS 4771", :role => "Viewer", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "testProfessor", :courseName => "COMS 4771", :role => "Prof", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)},

  {:uni => "testTA", :courseName => "COMS 4771", :role => "TA", 
   :created_at => DateTime.new(2023, 1, 1), :updated_at => DateTime.new(2023, 1, 1)}
]


taCalendars = [
  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 29, 14), 
  end_time: DateTime.new(2023, 11, 29, 14) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 1, 17), 
  end_time: DateTime.new(2023, 12, 1, 17) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 6, 14), 
  end_time: DateTime.new(2023, 12, 6, 14) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 8, 17), 
  end_time: DateTime.new(2023, 12, 8, 17) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 13, 14), 
  end_time: DateTime.new(2023, 12, 13, 14) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 15, 17), 
  end_time: DateTime.new(2023, 12, 15, 17) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 20, 14), 
  end_time: DateTime.new(2023, 12, 20, 14) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 22, 17), 
  end_time: DateTime.new(2023, 12, 22, 17) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 27, 14), 
  end_time: DateTime.new(2023, 12, 27, 14) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 29, 17), 
  end_time: DateTime.new(2023, 12, 29, 17) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 3 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 11, 29, 15), 
  end_time: DateTime.new(2023, 11, 29, 15) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 1, 21), 
  end_time: DateTime.new(2023, 12, 1, 21) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 6, 15), 
  end_time: DateTime.new(2023, 12, 6, 15) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 8, 21), 
  end_time: DateTime.new(2023, 12, 8, 21) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 13, 15), 
  end_time: DateTime.new(2023, 12, 13, 15) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 15, 21), 
  end_time: DateTime.new(2023, 12, 15, 21) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 20, 15), 
  end_time: DateTime.new(2023, 12, 20, 15) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 22, 21), 
  end_time: DateTime.new(2023, 12, 22, 21) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 27, 15), 
  end_time: DateTime.new(2023, 12, 27, 15) + 2.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 29, 21), 
  end_time: DateTime.new(2023, 12, 29, 21) + 1.hour, repeated_weeks: 4, location: "CSB 451", user_id: 6 }
]

profCalendars = [
  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 27, 12), 
  end_time: DateTime.new(2023, 11, 27, 12) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 11, 28, 9), 
  end_time: DateTime.new(2023, 11, 28, 9) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 4, 12), 
  end_time: DateTime.new(2023, 12, 4, 12) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 5, 9), 
  end_time: DateTime.new(2023, 12, 5, 9) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 11, 12), 
  end_time: DateTime.new(2023, 12, 11, 12) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 12, 9), 
  end_time: DateTime.new(2023, 12, 12, 9) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 18, 12), 
  end_time: DateTime.new(2023, 12, 18, 12) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 19, 9), 
  end_time: DateTime.new(2023, 12, 19, 9) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 25, 12), 
  end_time: DateTime.new(2023, 12, 25, 12) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "CSOR 4231", start_time: DateTime.new(2023, 12, 26, 9), 
  end_time: DateTime.new(2023, 12, 26, 9) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 2 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 11, 27, 9), 
  end_time: DateTime.new(2023, 11, 27, 9) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 11, 28, 10), 
  end_time: DateTime.new(2023, 11, 28, 10) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 4, 9), 
  end_time: DateTime.new(2023, 12, 4, 9) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 5, 10), 
  end_time: DateTime.new(2023, 12, 5, 10) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 11, 9), 
  end_time: DateTime.new(2023, 12, 11, 9) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 12, 10), 
  end_time: DateTime.new(2023, 12, 12, 10) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 18, 9), 
  end_time: DateTime.new(2023, 12, 18, 9) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 19, 10), 
  end_time: DateTime.new(2023, 12, 19, 10) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 25, 9), 
  end_time: DateTime.new(2023, 12, 25, 9) + 2.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },

  {courseName: "COMS 4771", start_time: DateTime.new(2023, 12, 26, 10), 
  end_time: DateTime.new(2023, 12, 26, 10) + 1.hour, repeated_weeks: 4, location: "Zoom (Link TBA)", user_id: 5 },
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