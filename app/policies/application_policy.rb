# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user_log_in?
  end

  def show?
    user_log_in?
  end

  def create?
    user_log_in?
  end

  def new?
    create?
  end

  def update?
    user_log_in?
  end

  def edit?
    update?
  end

  def destroy?
    user_log_in?
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
