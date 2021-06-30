FactoryBot.define do
  factory :user_movie_comment do
    comment { Faker::Name.comment }
  end
end
