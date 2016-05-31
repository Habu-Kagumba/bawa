FactoryGirl.define do
  factory :booking do
    booking_code { Faker::Code.flight }
    price Faker::Commerce.price

    factory :invalid_booking do
      flight_id nil
    end

    factory :booking_with_passengers do
      transient do
        passengers_count 3
      end
      after(:create) do |booking, evaluator|
        create_list(:passenger, evaluator.passengers_count, booking: booking)
      end
    end
  end
end
