# frozen_string_literal: true

json.producers @producers, :id, :first_name, :last_name, :created_at, :updated_at
json.partial! 'partials/pagination', collection: @producers
