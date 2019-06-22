# rubocop:disable all

require 'rails_helper'

RSpec.describe User::SkillLevel, type: :model do
  describe '#level' do
    it { should validate_presence_of(:level) }
    it { should validate_numericality_of(:level) }
  end

  describe '#user_id' do
    it { should validate_presence_of(:user_id) }
  end

  describe '#skill_id' do
    it { should validate_presence_of(:skill_id) }
  end
end
