FactoryGirl.define do
  factory :user do
    id 1
    first_name "Herbert"
    last_name "Kagumba"
    username "habu"
    password "password"
    password_confirmation "password"
    sequence :email do |e|
      "#{first_name}#{e}@example.com".downcase
    end
  end
end
