class ChangeColType < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :role
  	add_column :users, :role, :integer
  end
end
