class Genre < ApplicationRecord
  validates :title, uniqueness: true, presence: true, length: { in: 5..50, message: "allows string length 5..50" }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters"}
end

