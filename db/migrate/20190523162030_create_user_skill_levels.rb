# frozen_string_literal: true

# Create user_skill_levels
class CreateUserSkillLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :user_skill_levels do |t|
      t.integer :level

      t.belongs_to :user, foreign_key: true
      t.belongs_to :skill, foreign_key: true
      t.timestamps
    end
  end
end
