json.listings do
	json.array!(@listings) do |listing|
		json.name listing.name
		json.country listing.country
		json.state listing.state
		json.city listing.city
		json.url listing_path(listing.id)
	end
end