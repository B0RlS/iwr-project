require 'rails_helper'

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:valid_emails) { %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn] }
  let(:invalid_emails) { %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com] }

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

    it 'Email validation should reject invalid emails' do
      valid_emails.each do |valid_email|
        user.email = valid_email
        should allow_value(valid_email).for(:email)
      end
    end

    it 'Email validation should reject invalid emails' do
      invalid_emails.each do |invalid_email|
        user.email = invalid_email
        should_not allow_value(invalid_email).for(:email)
      end
    end

    it 'Email addresses should be unique' do
      duplicate_user = user.dup
      duplicate_user.save
      should_not allow_value(duplicate_user.email).for(:email)
    end
  end

  describe '#has_secure_password' do
    it { should have_secure_password }
  end

  describe '#password' do
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password).is_at_most(200) }

    it 'password should be present' do
      should allow_value(user.password).for(:password)
    end

    it 'password should have a minimum length' do
      user.password = user.password_confirmation = 'a' * 5
      should_not allow_value(user.password).for(:password)
    end

    it 'password should be equal password confirmation' do
      expect(user.password).to eq(user.password_confirmation)
    end
  end

  describe '#password_confirmation' do
    it { should validate_length_of(:password_confirmation).is_at_least(6) }
    it { should validate_length_of(:password_confirmation).is_at_most(200) }

    it 'password_confirmation should be present' do
      should allow_value(user.password_confirmation).for(:password_confirmation)
    end

    it 'password_confirmation should have a minimum length' do
      user.password = user.password_confirmation = 'a' * 5
      should_not allow_value(user.password_confirmation).for(:password_confirmation)
    end

    it 'password_confirmation should be equal password' do
      expect(user.password_confirmation).to eq(user.password)
    end
  end

  describe '#authenticated?' do
    it 'authenticated? should return false for a user with nil digest' do
      expect(create(:user).authenticated?('')).to eq(false)
    end
  end
end
