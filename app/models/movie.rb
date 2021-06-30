class Movie < ApplicationRecord
  validates :title, uniqueness: { case_sensitive: false }, presence: true, length: { in: 1..255, message: "allows string length 1..255" }
  validates :description, length: { in: 2..2000, message: "allows string length 2..2000" }
  validates :age_limit, length: { in: 1..6, message: "allows string length 1..6" }
  validates :budget, :box_office, numericality: { greater_than: 0 }
end
