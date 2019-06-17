# frozen_string_literal: true

class Skill < ApplicationRecord
  has_many :skill_levels,
           class_name: 'User::SkillLevel'

  has_many :users, through: :skill_levels

  validates :name, :sphere, presence: true
end
