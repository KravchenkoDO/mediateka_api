class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :like, -> (key, value) { where("#{key} ILIKE ?", "%#{value}%") if value.present? }
  scope :sorting_by_params, -> (key, value) { order("#{key} #{value}") }
  scope :less_or_equal, -> (key, value) { where("#{key} <= ?", "#{value}") if value.present? }
  scope :greater_or_equal, -> (key, value) { where("#{key} >= ?", "#{value}") if value.present? }
  scope :ordering_by_params, -> (field_name, order_type) { order("#{field_name} #{order_type}") }

end
