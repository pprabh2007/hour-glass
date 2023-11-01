Given /the following schedules exist/ do |schedules_table|
    schedules_table.hashes.each do |schedule|
        Schedule.create schedule
    end
end
