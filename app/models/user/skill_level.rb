# frozen_string_literal: true

class User
  class SkillLevel < ApplicationRecord
    belongs_to :user
    belongs_to :skill

    validates_numericality_of :level, greater_than_or_equal_to: 0,
                                      less_than_or_equal_to: 5
    validates :level, :user_id, :skill_id, presence: true
  end
end
