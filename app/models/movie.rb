class Movie < ApplicationRecord

  # model association
  has_and_belongs_to_many :companies, join_table: 'movie_companies'
  has_and_belongs_to_many :producers, join_table: 'movie_producers'
  has_and_belongs_to_many :genres, join_table: 'movie_genres'
  has_and_belongs_to_many :actors, join_table: 'movie_actors'
  belongs_to :poster
  has_many :user_movie_comments

  # validation
  validates :title, uniqueness: { case_sensitive: false }, presence: true,
            length: { in: 1..255, message: "allows string length 1..255" }
  validates :description, length: { in: 2..2000, message: "allows string length 2..2000" }
  validates :age_limit, length: { in: 1..10, message: "allows string length 1..10" }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :box_office, numericality: { greater_than_or_equal_to: 0 }

  def self.filtering(params)
    like(:title, params[:title])
      .like(:age_limit, params[:age_limit])
      .sorting_by_params(params[:sort_by] || 'created_at', params[:order] || 'desc')
  end
end
