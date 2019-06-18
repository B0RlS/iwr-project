require 'rails_helper'

RSpec.describe User::Education, type: :model do
  it { should belong_to(:user) }

  describe '#university' do
    it { should validate_presence_of(:university) }
    it { should validate_length_of(:university).is_at_least(3) }
    it { should validate_length_of(:university).is_at_most(15) }
  end

  describe '#faculty' do
    it { should validate_presence_of(:faculty) }
    it { should validate_length_of(:faculty).is_at_least(2) }
    it { should validate_length_of(:faculty).is_at_most(15) }
  end

  describe '#department' do
    it { should validate_presence_of(:department) }
    it { should validate_length_of(:department).is_at_least(3) }
    it { should validate_length_of(:department).is_at_most(15) }
  end

  describe '#entrance_year' do
    it { should validate_presence_of(:entrance_year) }
    it { should validate_numericality_of(:entrance_year).is_less_than(2020) }
    it { should validate_numericality_of(:entrance_year).is_greater_than(1950) }
  end

  describe '#graduation_year' do
    it { should validate_presence_of(:graduation_year) }
    it { should validate_numericality_of(:graduation_year).is_less_than(2025) }
    it { should validate_numericality_of(:graduation_year).is_greater_than(1955) }
  end
end
