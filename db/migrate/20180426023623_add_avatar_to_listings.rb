class AddAvatarToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :avatars, :json
  end
end
