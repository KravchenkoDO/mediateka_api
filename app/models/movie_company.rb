class MovieCompany < ApplicationRecord

  # model association
  belongs_to :movie
  belongs_to :company

end
