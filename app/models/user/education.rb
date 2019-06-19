# frozen_string_literal: true

class User
  class Education < ApplicationRecord
    belongs_to :user

    validates :university, presence: true, length: { minimum: 3, maximum: 15 }
    validates :faculty, presence: true, length: { minimum: 2, maximum: 15 }
    validates :department, presence: true, length: { minimum: 3, maximum: 15 }
    validates :graduation_year, presence: true,
                                numericality: { greater_than: 1955,
                                                less_than: 2025 }
    validates :entrance_year, presence: true,
                              numericality: { greater_than: 1950,
                                              less_than: :graduation_year }

    ENGLISH = %w[A0-(Beginner) A1(Elementary) A2(Pre-Intermediate)
                 B1(Intermediate) B2(Upper-Intermediate) C1(Advanced)].freeze
  end
end
