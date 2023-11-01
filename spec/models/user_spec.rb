require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(uni: "exampleuni", name: "Example User", password: "password")
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    user = User.new(uni: "exampleuni", name: "Example User")
    expect(user).not_to be_valid
  end

  it "should have many calendars" do
    association = described_class.reflect_on_association(:calendars)
    expect(association.macro).to eq :has_many
  end
end
