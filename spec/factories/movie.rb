FactoryBot.define do
  factory :movie do |movie|
    movie.title {"Horror"}
    movie.description {"Horror"}
    movie.age_limit {"Horror"}
  end

  factory :random_movie, class: Movie do
    title {Faker::Name}
    description {Faker::Name}
    age_limit {Faker::Name}
  end

end