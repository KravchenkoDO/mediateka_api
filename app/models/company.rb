class Company < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
