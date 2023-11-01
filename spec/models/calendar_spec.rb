require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let(:teaching_assistant) { TeachingAssistant.create(name: 'John Doe') }

  it 'is valid with valid attributes' do
    calendar = Calendar.new(class_id: 'CS101', start_time: DateTime.now, end_time: DateTime.now + 1.hour, teaching_assistant: teaching_assistant)
    expect(calendar).to be_valid
  end

  it 'is not valid without a class_id' do
    calendar = Calendar.new(start_time: DateTime.now, end_time: DateTime.now + 1.hour, teaching_assistant: teaching_assistant)
    expect(calendar).not_to be_valid
  end

  it 'is not valid without a start_time' do
    calendar = Calendar.new(class_id: 'CS101', end_time: DateTime.now + 1.hour, teaching_assistant: teaching_assistant)
    expect(calendar).not_to be_valid
  end

  it 'is not valid without an end_time' do
    calendar = Calendar.new(class_id: 'CS101', start_time: DateTime.now, teaching_assistant: teaching_assistant)
    expect(calendar).not_to be_valid
  end
end