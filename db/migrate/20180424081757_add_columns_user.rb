class AddColumnsUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :phone, :string
  	add_column :users, :country, :string
  	add_column :users, :birthdate, :string
  end
end
