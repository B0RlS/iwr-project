# frozen_string_literal: true

class Vacancy
  class RequestPolicy < ApplicationPolicy
    def create?
      not_owner?
    end

    private

    def not_owner?
      return false if user.nil? || record.vacancy.nil?

      user.id != record.vacancy.user_id
    end
  end
end
