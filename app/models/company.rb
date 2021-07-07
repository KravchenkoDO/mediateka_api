class Company < ApplicationRecord
  #include Filterable

  # model associations
  has_many :movie_companies
  has_many :movies, through: :movie_companies

  # model scoups
  scope :like, -> (key, value) { where("#{key} ILIKE ?", "%#{value}%") if value.present? }
  scope :less_or_equal, -> (key, value) { where("#{key} <= ?", "#{value}") if value.present? }
  scope :greater_or_equal, -> (key, value) { where("#{key} >= ?", "#{value}") if value.present? }
  scope :pagination, -> (page, per_page) { limit(per_page).offset(per_page.to_i * (page.to_i - 1)) }
  scope :ordering_by_params, -> (field_name, order_type) { order("#{field_name} #{order_type}") }

  # validation
  validates :name, uniqueness: { case_sensitive: false },
            presence: true,
            length: { in: 2..255, message: "allows string length 2..255" }

  def self.filtering(params)
    like(:name, params[:name])
      .less_or_equal(:created_at, params[:created_at_from])
      .greater_or_equal(:created_at, params[:created_at_to])
      .pagination(params[:page] || 1, params[:per_page] || 10)
      .ordering_by_params(params[:field_name] || :created_at, params[:order_type] || :desc)
  end
end
