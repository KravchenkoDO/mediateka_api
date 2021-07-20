class Producer < ApplicationRecord

  # model associations
  has_and_belongs_to_many :movies, join_table: 'movie_producers'

  validates :first_name, length: { in: 2..30, message: "allows string length 2..30" }
  validates :last_name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 2..50, message: "allows string length 2..50" }

  def self.filtering(params)
    like(:first_name, params[:first_name])
      .like(:last_name, params[:last_name])
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
