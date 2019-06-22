# frozen_string_literal: true

FactoryBot.define do
  factory :skill_levels, class: User::SkillLevel do
    level { 1 }

    user
    skill
  end
end
