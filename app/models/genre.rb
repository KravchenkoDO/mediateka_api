class Genre < ApplicationRecord
  validates :title, uniqueness: { case_sensitive: false },
            presence: true, length: { in: 5..50, message: "allows string length 5..50" }
end

