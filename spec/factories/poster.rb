FactoryBot.define do
  factory :random_link, class: Poster do
    link { Faker::Internet.email }
  end
end
