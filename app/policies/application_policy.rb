class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def show?
    user.admin? || user.user? if user
  end

  def create?
    user.admin? if user
  end

  def update?
    user.admin? if user
  end

  def destroy?
    user.admin? if user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
