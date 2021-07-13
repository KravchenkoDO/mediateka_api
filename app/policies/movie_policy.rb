class MoviePolicy < ApplicationPolicy

  def show?
    user.role=='admin' || user.present? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
