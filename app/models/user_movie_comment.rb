class UserMovieComment < ApplicationRecord
  validates :comment, length: { maximum: 2000 }
  validates :rating, acceptance: { accept: 1..5 }, presence: true

  scope :pagination, -> (page, per_page) { limit(per_page).offset(per_page.to_i * (page.to_i - 1)) }
  scope :sorting_by_params, -> (key, value) { order("#{key} #{value}") }

  def self.filtering(params)
    pagination(params[:page] || 1, params[:per_page] || 10)
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
