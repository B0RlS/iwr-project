# frozen_string_literal: true

class User
  class VacanciesController < ApplicationController
    def index
      @vacancies = Vacancy.where(user_id: current_user_id)
      authorize @vacancies
    end

    private

    def current_user_id
      return current_user.id if current_user.present?

      nil
    end
  end
end
