class Movie < ApplicationRecord

  # model association
  has_many :movie_companies
  has_many :companies, through: :movie_companies

  # validation
  validates :title, uniqueness: { case_sensitive: false }, presence: true,
            length: { in: 1..255, message: "allows string length 1..255" }
  validates :description, length: { in: 2..2000, message: "allows string length 2..2000" }
  validates :age_limit, length: { in: 1..10, message: "allows string length 1..10" }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :box_office, numericality: { greater_than_or_equal_to: 0 }

  scope :like, -> (key, value) { where("#{key} ILIKE ?", "%#{value}%") if value.present? }
  scope :pagination, -> (page, per_page) { limit(per_page).offset(per_page.to_i * (page.to_i - 1)) }
  scope :sorting_by_params, -> (key, value) { order("#{key} #{value}") }

  def self.filtering(params)
    like(:title, params[:title])
      .like(:age_limit, params[:age_limit])
      .pagination(params[:page] || 1, params[:per_page] || 10)
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
