# frozen_string_literal: true

json.genres @genres do |genre|
  json.id genre.id
  json.title genre.title
end
json.partial! 'partials/pagination', collection: @genres
