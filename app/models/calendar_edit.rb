class CalendarEdit < ActiveRecord::Base
    enum edit_type: { update_deletion: 0, update_addition: 1, deletion: 2 }
end
