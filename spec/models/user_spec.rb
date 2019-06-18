require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:profile).dependent(:destroy) }
  it { should have_one(:education).dependent(:destroy) }

  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_length_of(:name).is_at_most(30) }
  end

  describe '#surname' do
    it { should validate_presence_of(:surname) }
    it { should validate_length_of(:surname).is_at_least(5) }
    it { should validate_length_of(:surname).is_at_most(50) }
  end

  describe '#email' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(10) }
    it { should validate_length_of(:email).is_at_most(200) }
    it { should allow_value('example@example.com').for(:email) }
  end

  describe '#has_secure_password' do
    it { should have_secure_password }
  end

  describe '#password' do
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password).is_at_most(200) }
  end

  describe '#authenticated?' do
    it 'authenticated? should return false for a user with nil digest' do
      expect(create(:user).authenticated?('')).to eq(false)
    end
  end
end
