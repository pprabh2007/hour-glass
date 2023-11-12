class AddIsProfessorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_professor, :boolean
  end
end
