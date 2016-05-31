FactoryGirl.define do
  factory :airport do
    name { Faker::Address.street_name }
    location { Faker::Address.city }
  end
end
