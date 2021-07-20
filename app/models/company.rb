class Company < ApplicationRecord
  #include Filterable

  # model associations
  has_and_belongs_to_many :movies, join_table: 'movie_companies'

  # validation
  validates :name, uniqueness: { case_sensitive: false },
            presence: true,
            length: { in: 2..255, message: "allows string length 2..255" }

  def self.filtering(params)
    like(:name, params[:name])
      .less_or_equal(:created_at, params[:created_at_from])
      .greater_or_equal(:created_at, params[:created_at_to])
      .ordering_by_params(params[:field_name] || :created_at, params[:order_type] || :desc)
  end
end
