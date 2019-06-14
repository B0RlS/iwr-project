# frozen_string_literal: true

class Vacancy
  class AttributePolicy < ApplicationPolicy
    def edit?
      owner?
    end

    def create?
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
      return false if user.nil? || record.nil?

      user.id == vacancy_user_id
    end

    def vacancy_user_id
      record.vacancy.user_id
    end
  end
end
