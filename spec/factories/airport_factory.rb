FactoryGirl.define do
  factory :airport do
    name { Faker::Company.name }
    location { Faker::Address.city }
  end
end
