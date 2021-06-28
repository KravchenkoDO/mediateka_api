FactoryBot.define do
  factory :movie do |movie|
    movie.title {"Horror"}
  end

  factory :random_movie, class: Movie do
    title {Faker::Name}
  end

end