FactoryBot.define do
  factory :producer do |producer|
    producer.first_name {"Departed"}
    producer.last_name {"Departed"}
  end

  factory :random_producer, class: 'Producer' do
    first_name{Faker::Name}
    last_name {Faker::Name}
  end

end