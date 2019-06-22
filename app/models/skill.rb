# frozen_string_literal: true

class Skill < ApplicationRecord
  has_many :skill_levels,
           class_name: 'User::SkillLevel'

  has_many :users, through: :skill_levels

  validates :name, :sphere, presence: true

  def self.left_join_skill_levels(id)
    joins("LEFT OUTER JOIN user_skill_levels
           ON user_skill_levels.skill_id = skills.id
           AND user_skill_levels.user_id=#{id}")
      .select('user_skill_levels.level,
               user_skill_levels.id AS skill_level_id,
               skills.name, skills.sphere, skills.id')
  end

  def self.inner_join_skill_levels(id)
    joins(:skill_levels)
      .where("user_skill_levels.user_id=#{id}")
      .select('user_skill_levels.level, skills.name, skills.sphere')
  end
end
