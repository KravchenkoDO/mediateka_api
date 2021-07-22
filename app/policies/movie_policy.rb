class MoviePolicy < ApplicationPolicy

  def show?
    user.admin? || user.user? if user
  end

  def create?
    user.admin? || user.present? if user
  end

  def update?
    user.role == 'admin' || user.present? if user
  end

  def destroy?
    user.role == 'admin' || user.present? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
