class UserMovieComment < ApplicationRecord

  # model association
  belongs_to :movie
  belongs_to :user

  validates :comment, length: { maximum: 2000 }
  validates :rating, acceptance: { accept: 1..5 }, presence: true

  def self.filtering(params)
    sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
