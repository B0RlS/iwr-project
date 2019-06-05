# frozen_string_literal: true

# UserPolicy class
class UserPolicy < ApplicationPolicy
  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    user == record
  end
end
