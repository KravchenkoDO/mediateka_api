# frozen_string_literal: true

json.companies @companies do |company|
  json.id company.id
  json.name company.name
  json.created_at company.created_at
  json.updated_at company.updated_at
end
json.partial! 'partials/pagination', collection: @companies
