class Entitlement < ActiveRecord::Base

    # Checks if an entitlement that gives permissions equal to 
    # or stronger than the input already exists in the database
    def self.equivalent_perm_exists?(uni, courseId, role)
        if role == "Prof"
            prof_entitlement = Entitlement.find_by(uni: uni, courseId: courseId, role: "Prof")
            return !prof_entitlement.nil?
        elsif role == "TA"
            prof_entitlement = Entitlement.find_by(uni: uni, courseId: courseId, role: "Prof")
            ta_entitlement = Entitlement.find_by(uni: uni, courseId: courseId, role: "TA")
            return (!prof_entitlement.nil?) || (!ta_entitlement.nil?)
        else
            any_entitlement = Entitlement.find_by(uni: uni, courseId: courseId)
            return !any_entitlement.nil?
        end
    end
end
