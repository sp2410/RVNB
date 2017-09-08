json.extract! listing, :id, :title, :description, :year, :length, :sleeps, :rateperhour, :vehicletype, :rentalminimum, :latitude, :longitude, :city, :imagefront, :imageback, :imageleft, :imageright, :interiorfront, :interiorback, :created_at, :updated_at
json.url listing_url(listing, format: :json)
