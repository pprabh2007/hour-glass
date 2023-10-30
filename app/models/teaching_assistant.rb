# app/models/teaching_assistant.rb
class TeachingAssistant < ActiveRecord::Base
    # Assuming there is a one-to-many relationship between TeachingAssistant and Calendar
    has_many :calendars
  
    # Add any other necessary validations
    validates :name, presence: true
  end