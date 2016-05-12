FactoryGirl.define do
  factory :passenger do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    booking_id 1
  end
end
