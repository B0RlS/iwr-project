# frozen_string_literal: true

class VacancyPolicy < ApplicationPolicy
  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    return false if user.nil? || record.nil?

    user.id == record.user_id
  end
end
