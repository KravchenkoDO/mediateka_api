# frozen_string_literal: true

json.movies @movies do |movie|
  json.id movie.id
  json.title movie.title
  json.description movie.description
  json.age_limit movie.age_limit
  json.budget movie.budget
  json.box_office movie.box_office
end
json.partial! 'partials/pagination', collection: @movies
