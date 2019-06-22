# frozen_string_literal: true

class Vacancy
  class CountrySearchController < ApplicationController
    def index
      @vacancies = Vacancy.where(country: params[:country],
                                 publish: true)
      authorize @vacancies
    end
  end
end
