json.extract! reservation, :id, :status, :startdate, :endate, :numberofguests, :needcaptain, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
