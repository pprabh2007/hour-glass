Given /the following calendars exist/ do |calendars_table|
    calendars_table.hashes.each do |calendar|
        Calendar.create calendar
    end
end
