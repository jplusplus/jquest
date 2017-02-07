FactoryGirl.define do
  factory :user do
    firstname "John"
    lastname  "Doe"
    role 'student'
    home_country 'FR'
    spoken_language 'fr'
    group
    sequence(:email) do |n|
      "#{firstname}.#{lastname}.#{n}@jquestapp.com".downcase
    end
  end

  factory :group do
    season
  end

  factory :season do
    sequence(:name) do |n|
      "Season #{n}"
    end
    engine_name 'JquestPg'
  end
end
