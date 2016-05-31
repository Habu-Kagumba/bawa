FactoryGirl.define do
  factory :passenger do
    first_name { Faker::Name.first_name + "abc" }
    last_name { Faker::Name.last_name + "abc" }
    email { Faker::Internet.safe_email }
  end
end
