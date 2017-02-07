FactoryGirl.define do
  factory :user do
    firstname "John"
    lastname  "Doe"
    role 'student'
    home_country 'FR'
    sequence(:email) do |n|
      "#{firstname}.#{lastname}.#{n}@jquestapp.com".downcase
    end
  end
end
