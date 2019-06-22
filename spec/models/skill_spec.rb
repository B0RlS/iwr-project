# rubocop:disable all

require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
  end

  describe '#sphere' do
    it { should validate_presence_of(:sphere) }
  end
end
