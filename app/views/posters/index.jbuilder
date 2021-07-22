# frozen_string_literal: true

json.posters @posters do |poster|
  json.id poster.id
  json.link poster.link
end
json.partial! 'partials/pagination', collection: @posters
