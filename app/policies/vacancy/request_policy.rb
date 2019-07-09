# frozen_string_literal: true

class Vacancy
  class RequestPolicy < ApplicationPolicy
    def create?
      not_owner?
    end

    def update?
      vacancy_owner? && user.manager?
    end

    private

    def not_owner?
      return false if user.nil? || record.vacancy.nil?

      user.id != record.vacancy.user_id
    end

    def vacancy_owner?
      record.vacancy.user_id == user.id
    end
  end
end
