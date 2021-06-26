class UserMovieComment < ApplicationRecord
  validates :comments, length: { maximum: 2000 }, format: { with: /([A-z0-9])/ }
end
