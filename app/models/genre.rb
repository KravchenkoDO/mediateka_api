class Genre < ApplicationRecord
  validates :title, uniqueness: { case_sensitive: false }, presence: true, length: { in: 5..50, message: "allows string length 5..50" }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end

