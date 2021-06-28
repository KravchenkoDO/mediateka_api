class Movie < ApplicationRecord
  validates :title, uniqueness: {case_sensitive: false}, presence: true
  validates :budget, :box_office, numericality: { only_integer: true }
end
