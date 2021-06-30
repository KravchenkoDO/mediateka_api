class UserMovieComment < ApplicationRecord
  validates :comment, length: { maximum: 2000 }, presence: true
end
