FactoryGirl.define do
  factory :user do
    first_name { "#{Faker::Name.first_name}abc" }
    last_name { "#{Faker::Name.last_name}abc" }
    username { "#{Faker::Name.first_name}abc" }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(8) }

    factory :invalid_user do
      first_name nil
      email nil
    end
  end
end
