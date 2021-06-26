FactoryBot.define do
  factory :actor do |actor|
    actor.name {"Departed"}
  end

  factory :random_actor, class: 'Actor' do
    lastname {Faker::Name}
  end

end