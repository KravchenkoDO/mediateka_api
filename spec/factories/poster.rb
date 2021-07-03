FactoryBot.define do
  factory :poster, class: Poster do
    link { Faker::Internet.domain_name }
  end
end
