class Producer < ApplicationRecord
  validates :lastname, uniqueness: true, presence: true
end
