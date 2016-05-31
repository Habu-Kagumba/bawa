FactoryGirl.define do
  factory :flight do
    departure_date { Faker::Date.between(Date.today, 1.year.from_now).to_s }
    departure_location_id 2
    arrival_date { Faker::Date.between(3.days.from_now, 1.year.from_now).to_s }
    arrival_location_id 1
    flight_number { Faker::Code.flight }
    airline { Faker::Code.airline }
    price { Faker::Commerce.price }
  end
end
