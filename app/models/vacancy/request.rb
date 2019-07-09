# frozen_string_literal: true

class Vacancy < ApplicationRecord
  class Request < ApplicationRecord
    belongs_to :vacancy
    belongs_to :user
  end
end
