require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }

  describe '#telephone' do
    it { should validate_presence_of(:telephone) }
    it { should validate_numericality_of(:telephone) }
    it { should validate_length_of(:telephone).is_at_least(10) }
    it { should validate_length_of(:telephone).is_at_most(15) }
  end

  describe '#country_code' do
    it { should validate_presence_of(:country_code) }
    it { should validate_length_of(:country_code).is_at_least(2) }
    it { should validate_length_of(:country_code).is_at_most(2) }
  end

  describe '#city' do
    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_at_least(3) }
    it { should validate_length_of(:city).is_at_most(20) }
  end

  describe '#birthday' do
    it { should validate_presence_of(:birthday) }
  end
end
