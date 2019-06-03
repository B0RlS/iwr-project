# frozen_string_literal: true
# rubocop:disable all

require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { User.create(valid_params) }
  let(:valid_params) do
    {
      name: 'TestName',
      surname: 'TestSurname',
      email: 'example@example.com',
      password: '1234567'
    }
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
# rubocop:enable all
