class AddUserIdToCalendars < ActiveRecord::Migration
  def change
    add_reference :calendars, :user, index: true, foreign_key: true
  end
end
