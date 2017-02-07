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

  factory :season, class: Season do
    sequence(:name) do |n|
      "Season #{n}"
    end
    engine_name 'JquestPg'
  end

  factory :group do
    association :season, factory: :season
  end
end
