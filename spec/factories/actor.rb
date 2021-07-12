FactoryBot.define do
  factory :actor do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
  end
end
