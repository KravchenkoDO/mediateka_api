FactoryBot.define do
  factory :user_movie_comment do |user_movie_comment|
    user_movie_comment.comment {"Departed"}
  end

  factory :random_user_movie_comment, class: 'UserMovieComment' do
    comment {Faker::Name}
  end

end