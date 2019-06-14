require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  it { should have_many(:body_attributes).dependent(:destroy) }
  it { should belong_to(:specialty) }

  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(10) }
    it { should validate_length_of(:name).is_at_most(30) }
  end

  describe '#description' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(50) }
    it { should validate_length_of(:description).is_at_most(2000) }
  end

  describe '#country' do
    it { should validate_presence_of(:country) }
  end

  describe '#city' do
    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_at_least(3) }
    it { should validate_length_of(:city).is_at_most(25) }
  end

  describe '#country_name' do
    let(:vacancy) { Vacancy.new(country: :BY) }

    it 'returns fullname of country code' do
      expect(vacancy.country_name).to eq('Belarus')
    end
  end
end
