# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
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
