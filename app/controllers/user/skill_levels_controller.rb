# frozen_string_literal: true

class User
  class SkillLevelsController < ApplicationController
    def edit
      @user = current_user
      @skills = Skill.all
      @skill_levels = User::SkillLevel.where(user_id: @user.id)
    end
  end
end
