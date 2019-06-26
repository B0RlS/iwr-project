# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    admin?
  end

  def update?
    owner? || admin?
  end

  def destroy?
    owner? || admin?
  end

  private

  def owner?
    user == record
  end

  def admin?
    user.admin?
  end
end
