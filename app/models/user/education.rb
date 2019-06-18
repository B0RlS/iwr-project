# frozen_string_literal: true

class User
  class Education < ApplicationRecord
    belongs_to :user

    validates :university, presence: true, length: { minimum: 3, maximum: 15 }
    validates :faculty, presence: true, length: { minimum: 2, maximum: 15 }
    validates :department, presence: true, length: { minimum: 3, maximum: 15 }
    validates :entrance_year, presence: true, numericality:
                                                          { greater_than: 1950,
                                                            less_than: 2020 }
    validates :graduation_year, presence: true,
                                numericality: { greater_than: 1955,
                                                less_than: 2025 }

    ENGLISH = %w[A1 A2 B1 B2 C1 C2].freeze
  end
end
