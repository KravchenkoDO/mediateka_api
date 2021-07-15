class ActorPolicy < ApplicationPolicy

  def show?
    (user.role == 'admin' || user.role == 'current_user') || user.present? if user
  end

  def create?
    user.role == 'admin' || user.present? if user
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
