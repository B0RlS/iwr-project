# frozen_string_literal: true

class Vacancy < ApplicationRecord
  class Specialty < ApplicationRecord
    has_many :vacancies
  end
end
