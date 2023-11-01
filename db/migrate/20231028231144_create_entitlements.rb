class CreateEntitlements < ActiveRecord::Migration
  def change
    create_table :entitlements do |t|
      t.string :uni
      t.string :courseId
      t.string :role

      t.timestamps null: false
    end
  end
end
