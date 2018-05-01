json.extract! reservation, :id, :users_id, :listings_id, :start_date, :end_date, :guest_number, :verified, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
