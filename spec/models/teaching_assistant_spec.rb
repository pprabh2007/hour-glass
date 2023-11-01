require 'rails_helper'

RSpec.describe TeachingAssistant, type: :model do
  it "is valid with valid attributes" do
    teaching_assistant = TeachingAssistant.new(name: "John Doe")
    expect(teaching_assistant).to be_valid
  end

  it "is not valid without a name" do
    teaching_assistant = TeachingAssistant.new
    expect(teaching_assistant).not_to be_valid
  end

  it "should have many calendars" do
    association = described_class.reflect_on_association(:calendars)
    expect(association.macro).to eq :has_many
  end
end
