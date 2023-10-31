class AddCourseDescriptionToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :courseDescription, :string
  end
end
