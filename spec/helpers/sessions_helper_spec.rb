# frozen_string_literal: true
# rubocop:disable all

require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { User.create(valid_params) }
  let(:valid_params) do
    {
      name: 'Boris',
      surname: 'Tsarikov',
      email: 'example@example.com',
      password: '1234567'
    }
  end

  describe '#current_user' do
    it 'current_user should return right user when session is nil' do
      remember(user)
      expect(current_user).to eq(user)
      expect(logged_in?).to eq(true)
    end

    it 'current_user returns nil when remember digest is wrong' do
      remember(user)
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to eq(nil)
    end
  end

  describe '#log_out' do
    it 'log_out should return nil when session is delete' do
      remember(user)
      expect(current_user).to eq(user)
      expect(log_out).to eq(nil)
    end
  end

  describe '#log_in' do
    it 'log_in should return session user id when session is success' do
      remember(user)
      current_user
      expect(log_in(user)).to eq(user.id)
    end
  end
end

# rubocop:enable all