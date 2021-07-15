class Genre < ApplicationRecord

  validates :title, uniqueness: { case_sensitive: false }, presence: true, length: { in: 5..50, message: "allows string length 5..50" }

  def self.filtering(params)
    like(:title, params[:title])
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
