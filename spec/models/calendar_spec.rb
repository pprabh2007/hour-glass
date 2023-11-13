require 'rails_helper'

RSpec.describe Calendar, type: :model do
  it 'is valid with valid attributes' do
    calendar = Calendar.new(courseName: 'CS101', start_time: DateTime.now, end_time: DateTime.now + 1.hour, repeated_weeks: 5)
    expect(calendar).to be_valid
  end

  it 'is not valid without a courseName' do
    calendar = Calendar.new(start_time: DateTime.now, end_time: DateTime.now + 1.hour,  repeated_weeks: 1)
    expect(calendar).not_to be_valid
  end

  it 'is not valid without a start_time' do
    calendar = Calendar.new(courseName: 'CS101', end_time: DateTime.now + 1.hour, repeated_weeks: 2)
    expect(calendar).not_to be_valid
  end

  it 'is not valid without an end_time' do
    calendar = Calendar.new(courseName: 'CS101', start_time: DateTime.now, repeated_weeks: 3)
    expect(calendar).not_to be_valid
  end

  it 'is valid without a repeated_weeks as it defaults to 0' do
    calendar = Calendar.new(courseName: 'CS101', start_time: DateTime.now, end_time: DateTime.now + 1.hour)
    expect(calendar).to be_valid
    expect(calendar.repeated_weeks == 0)
  end
end
