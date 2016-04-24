FactoryGirl.define do
  factory :user do
    id 1
    first_name "Herbert"
    last_name "Kagumba"
    username "habu"
    password "password"
    password_confirmation "password"
    email "herbert.kagumba@example.com"
  end
end
