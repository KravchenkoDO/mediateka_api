FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Movie.name }
    age_limit { Faker::Name.name}
  end
end
