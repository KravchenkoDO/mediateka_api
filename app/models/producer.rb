class Producer < ApplicationRecord

  scope :like, -> (key, value) { where("#{key} ILIKE ?", "%#{value}%") if value.present? }
  scope :pagination, -> (page, per_page) { limit(per_page).offset(per_page.to_i * (page.to_i - 1)) }
  scope :sorting_by_params, -> (key, value) { order("#{key} #{value}") }

  validates :first_name, length: { in: 2..30, message: "allows string length 2..30" }
  validates :last_name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 2..50, message: "allows string length 2..50" }

  def self.filtering(params)
    like(:first_name, params[:first_name])
      .like(:last_name, params[:last_name])
      .pagination(params[:page] || 1, params[:per_page] || 10)
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
