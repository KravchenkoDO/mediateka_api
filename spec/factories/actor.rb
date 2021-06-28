FactoryBot.define do
  factory :actor do |actor|
    actor.last_name {"Departed"}
  end

  factory :random_actor, class: 'Actor' do
    last_name {Faker::Name}
  end

end