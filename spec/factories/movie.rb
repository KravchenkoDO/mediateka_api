FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Movie.name }
    age_limit { Faker::Name.initials(number: 8) }
    budget { Faker::Number.between(from: 1, to: 10) }
    box_office { Faker::Number.between(from: 1, to: 10) }
  end
end
