require 'rails_helper'

RSpec.describe Calendar, type: :model do
  it 'is valid with valid attributes' do
    calendar = Calendar.new(courseName: 'CS101', start_time: DateTime.now, end_time: DateTime.now + 1.hour, recurrence: '1')
    expect(calendar).to be_valid
  end

  it 'is not valid without a courseName' do
    calendar = Calendar.new(start_time: DateTime.now, end_time: DateTime.now + 1.hour, recurrence: '1')
    expect(calendar).not_to be_valid
  end

  it 'is not valid without a start_time' do
    calendar = Calendar.new(courseName: 'CS101', end_time: DateTime.now + 1.hour, recurrence: '1')
    expect(calendar).not_to be_valid
  end

  it 'is not valid without an end_time' do
    calendar = Calendar.new(courseName: 'CS101', start_time: DateTime.now, recurrence: '1')
    expect(calendar).not_to be_valid
  end

  it 'is not valid without a recurrence' do
    calendar = Calendar.new(courseName: 'CS101', start_time: DateTime.now, end_time: DateTime.now + 1.hour)
    expect(calendar).not_to be_valid
  end
end
