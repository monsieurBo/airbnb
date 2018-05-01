class RenameColumnToReservations < ActiveRecord::Migration[5.0]
  def change
  	rename_column :reservations, :users_id, :user_id
  	rename_column :reservations, :listings_id, :listing_id
  end
end
