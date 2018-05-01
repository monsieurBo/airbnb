class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :users, foreign_key: true
      t.references :listings, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :guest_number
      t.boolean :verified

      t.timestamps
    end
  end
end
