class UserMovieComment < ApplicationRecord
  validates :comment, length: { maximum: 2000 }, format: { with: /([A-z0-9])/ }
end
