# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def edit?
    owner?
  end

  def update?
    owner?
  end

  private

  def owner?
    user == record.user
  end
end
