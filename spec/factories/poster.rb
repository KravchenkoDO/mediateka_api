FactoryBot.define do
  factory :poster do |poster|
    poster.link {"email"}
  end

  factory :random_link, class: Poster do
    link {Faker::Internet.email}
  end

end