class Genre < ApplicationRecord

  # model associations
  has_and_belongs_to_many :movies

  validates :title, uniqueness: { case_sensitive: false }, presence: true, length: { in: 5..50, message: "allows string length 5..50" }

  def self.filtering(params)
    like(:title, params[:title])
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
