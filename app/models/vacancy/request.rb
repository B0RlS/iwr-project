# frozen_string_literal: true

class Vacancy
  class Request < ApplicationRecord
    belongs_to :vacancy
    belongs_to :user
  end
end
