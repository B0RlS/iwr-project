# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.director?
        scope.where("users.role=#{User.roles[:manager]}
           OR users.role=#{User.roles[:employee]}")
      end
    end
  end

  def show?
    admin? || director? || manager?
  end

  def update?
    owner? || admin? || director?
  end

  def destroy?
    owner? || admin?
  end

  def manager?
    user.manager?
  end

  private

  def owner?
    user == record
  end

  def admin?
    user.admin?
  end

  def director?
    user.director?
  end
end
