# frozen_string_literal: true

# ApplicationPolicy class
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError if user.nil?

    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    user_log_in?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # Scope class
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

  private

  def user_log_in?
    raise Pundit::NotAuthorizedError if user.nil?

    true
  end
end
