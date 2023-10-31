Given /the following entitlements exist/ do |entitlements_table|
    entitlements_table.hashes.each do |entitlement|
        Entitlement.create entitlement
    end
end