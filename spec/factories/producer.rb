FactoryBot.define do
  factory :producer do
    sequence :first_name do |n|
      "first_name #{n}"
    end

    sequence :last_name do |n|
      "last_name #{n}"
    end
  end
end
