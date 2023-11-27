When(/^I select "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" for the start-time$/) do |time1, time2, time3, time4|
    select(time1, from: 'calendar_start_time_1i')
    select(time2, from: 'calendar_start_time_2i')
    select(time3, from: 'calendar_start_time_3i')
    select(time4, from: 'calendar_start_time_4i')
end

When(/^I select "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" for the end-time$/) do |time1, time2, time3, time4|
    select(time1, from: 'calendar_end_time_1i')
    select(time2, from: 'calendar_end_time_2i')
    select(time3, from: 'calendar_end_time_3i')
    select(time4, from: 'calendar_end_time_4i')
end