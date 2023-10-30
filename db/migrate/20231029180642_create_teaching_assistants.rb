class CreateTeachingAssistants < ActiveRecord::Migration
  def change
    create_table :teaching_assistants do |t|
      t.string :name
      t.string :email
      t.integer :class_id
      # Add other necessary fields

      t.timestamps
    end
  end
end