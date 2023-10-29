class AddTeachingAssistantToCalendars < ActiveRecord::Migration
  def change
    add_reference :calendars, :teaching_assistant, index: true, foreign_key: true
  end
end
