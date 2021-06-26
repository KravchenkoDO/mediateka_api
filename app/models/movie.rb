class Movie < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates :budget, :box_office, numericality: { only_integer: true }
end
