class Producer < ApplicationRecord
  validates :last_name, uniqueness: {case_sensitive: false}, presence: true
end
