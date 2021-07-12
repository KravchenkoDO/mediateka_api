FactoryBot.define do
  factory :user_movie_comment do
    comment { Faker::Music.name }
    rating { Faker::Number.between(from: 1, to: 5) }
  end
end
