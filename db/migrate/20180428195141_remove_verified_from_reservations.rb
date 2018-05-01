class RemoveVerifiedFromReservations < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reservations, :verified
  	add_column :reservations, :accepted, :boolean
  end
end
