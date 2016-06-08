FactoryGirl.define do
  factory :booking do
    booking_code { Faker::Code.flight }
    price Faker::Commerce.price

    transient do
      flight_id { create(:flight).id }
    end

    flight { FactoryGirl.create(:flight) }

    passengers do
      [].tap do |pass|
        2.times { pass << create(:passenger) }
      end
    end

    factory :user_booking do
      transient do
        user_id { create(:user).id }
      end
      user { FactoryGirl.create(:user) }
    end
  end
end
