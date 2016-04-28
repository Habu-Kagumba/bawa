FactoryGirl.define do
  factory :flight do
    departure_date "2016-04-26 19:40"
    departure_location_id 2
    arrival_date "2016-05-26 09:20"
    arrival_location_id 1
    flight_number "JQ3451"
    airline "KLM"
  end
end
