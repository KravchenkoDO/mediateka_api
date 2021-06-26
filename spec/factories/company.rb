FactoryBot.define do
  factory :company do |company|
    company.name {"Departed"}
  end

  factory :random_company, class: 'Company' do
    name {Faker::Name}
  end

end