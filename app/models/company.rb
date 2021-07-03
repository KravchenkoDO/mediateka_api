class Company < ApplicationRecord

  # model association
  has_many :movie_companies
  has_many :movies, through: :movie_companies

  # validation
  validates :name, uniqueness: { case_sensitive: false },
            presence: true,
            length: { in: 2..255, message: "allows string length 2..255" }
end
