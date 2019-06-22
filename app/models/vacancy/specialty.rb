# frozen_string_literal: true

class Vacancy
  class Specialty < ApplicationRecord
    has_many :vacancies
  end
end
