# frozen_string_literal: true

class Vacancy
  class Attribute < ApplicationRecord
    belongs_to :vacancy

    validates :attr_type, presence: true
    validates :name, presence: true
  end
end
