require 'rails_helper'

RSpec.describe Entitlement, type: :model do

  before(:each) do
    Entitlement.delete_all
  end

  context 'check if equivalent perm exists method works' do
    it 'when no permissions exist' do
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Viewer")).to be false
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "TA")).to be false
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Prof")).to be false
    end

    it 'when viewer permissions exist' do
      viewer_entitlement = Entitlement.create(uni: "testUni", courseName: "COMS 4152", role: "Viewer")
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Viewer")).to be true
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "TA")).to be false
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Prof")).to be false
      viewer_entitlement.destroy
    end

    it 'when TA permissions exist' do
      ta_entitlement = Entitlement.create(uni: "testUni", courseName: "COMS 4152", role: "TA")
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Viewer")).to be true
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "TA")).to be true
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Prof")).to be false
      ta_entitlement.destroy
    end

    it 'when Prof permissions exist' do
      prof_entitlement = Entitlement.create(uni: "testUni", courseName: "COMS 4152", role: "Prof")
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Viewer")).to be true
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "TA")).to be true
      expect(Entitlement.equivalent_perm_exists?("testUni", "COMS 4152", "Prof")).to be true
      prof_entitlement.destroy
    end
  end
end
