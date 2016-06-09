FactoryGirl.define do
  factory :flight do
    departure_date { Faker::Date.between(Date.today, 1.year.from_now).to_s }
    arrival_date { Faker::Date.between(3.days.from_now, 1.year.from_now).to_s }
    flight_number { Faker::Code.flight }
    airline { Faker::Code.airline }
    price { Faker::Commerce.price }

    transient do
      departure_location_id { create(:airport).id }
      arrival_location_id { create(:airport).id }
    end

    departure_location do
      FactoryGirl.create(:airport)
    end

    arrival_location do
      FactoryGirl.create(:airport)
    end
  end
end
