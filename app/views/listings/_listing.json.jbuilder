json.extract! listing, :id, :name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
