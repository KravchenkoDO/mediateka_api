FactoryBot.define do
  factory :genre do |genre|
    genre.title {"Horror"}
  end

  factory :random_genre, class: Genre do
    title {Faker::Name}
  end

end