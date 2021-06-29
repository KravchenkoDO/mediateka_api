FactoryBot.define do
  factory :actor do |actor|
    actor.first_name{"Departed"}
    actor.last_name {"Departed"}
  end

  factory :random_actor, class: 'Actor' do
    first_name{Faker::Name}
    last_name {Faker::Name}
  end
end
