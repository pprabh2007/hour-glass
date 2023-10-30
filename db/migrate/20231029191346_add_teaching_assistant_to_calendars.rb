class AddTeachingAssistantIdToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :teaching_assistant_id, :integer
  end
end