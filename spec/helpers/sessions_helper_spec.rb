require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }

  describe '#log_out' do
    before do
      log_in(user)
    end
    it 'change current_user to nil' do
      expect{ log_out }.to change { current_user }.to(nil)
    end
    before do
      log_in(user)
    end
    it 'remove session' do
      expect{ log_out }.to change { session[:user_id] }.to(nil)
    end
  end

  describe '#log_in' do
    it 'log_in should return session user id when session is success' do
      expect(log_in(user)).to eq(user.id)
    end
  end

  describe '#current_user' do
    context 'if logged in' do
      before do
        log_in(user)
      end
      it 'returns right user' do
        expect(current_user).to eq(user)
      end
    end
    context 'if not logged in' do
      it 'returns nil' do
        expect(current_user).to eq(nil)
      end
    end
  end
end
