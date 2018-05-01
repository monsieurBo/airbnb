class ChangeColumnTypeToUsersListings < ActiveRecord::Migration[5.0]
  def change
  	change_column :listings, :verified, :boolean, default: false
  	change_column :users, :role, :integer, default: 0
  end
end
