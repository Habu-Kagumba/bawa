json.array!(@bookings) do |booking|
  json.extract! booking, :id
  json.url booking_url(booking, format: :json)
end
