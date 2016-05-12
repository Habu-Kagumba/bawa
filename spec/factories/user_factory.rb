FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name + "abc" }
    last_name { Faker::Name.first_name + "abc" }
    username { Faker::Name.first_name + "abc" }
    password "password"
    password_confirmation "password"
    email { Faker::Internet.email }
  end
end
