Given /the following entitlements exist/ do |courses_table|
    courses_table.hashes.each do |course|
        Course.create course
    end
end