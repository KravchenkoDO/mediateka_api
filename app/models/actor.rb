class Actor < ApplicationRecord
  validates :lastname, uniqueness: true, presence: true
end
