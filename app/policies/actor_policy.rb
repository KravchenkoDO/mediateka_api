# frozen_string_literal: true

class ActorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end