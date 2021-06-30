class Company < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 2..255, message: "allows string length 2..255" }
end
