# frozen_string_literal: true

json.posters @posters do |poster|
  json.id poster.id
  json.link poster.link
  json.created_at poster.created_at
  json.updated_at poster.updated_at
end
json.partial! 'partials/pagination', collection: @posters
