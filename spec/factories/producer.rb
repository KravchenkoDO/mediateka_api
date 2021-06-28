FactoryBot.define do
  factory :producer do |producer|
    producer.last_name {"Departed"}
  end

  factory :random_producer, class: 'Producer' do
    last_name {Faker::Name}
  end

end