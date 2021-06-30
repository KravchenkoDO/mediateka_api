class Actor < ApplicationRecord
  validates :first_name, length: { in: 2..30, message: "allows string length 2..30" }
  validates :last_name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 2..50, message: "allows string length 2..50" }
end
