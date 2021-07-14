# frozen_string_literal: true

json.actors @actors do |actor|
  json.id actor.id
  json.first_name actor.first_name
  json.last_name actor.last_name
end
json.partial! 'partials/pagination', collection: @actors
