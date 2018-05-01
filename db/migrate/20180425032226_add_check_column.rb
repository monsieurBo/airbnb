class AddCheckColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :role, :string

  	add_column :listings, :verified, :boolean
  end
end
