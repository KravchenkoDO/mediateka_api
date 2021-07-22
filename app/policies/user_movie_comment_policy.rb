class UserMovieCommentPolicy < ApplicationPolicy

  def create?
    user.admin? || user.user? if user
  end

  def update?
    user.admin? || (user.user? && record.user == user) if user
  end

  def destroy?
    user.admin? || (user.user? && record.user == user) if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
