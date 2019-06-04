# frozen_string_literal: true
# rubocop:disable all

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create(valid_params) }
  let(:valid_params) do
    {
      name: 'Boris',
      surname: 'Tsarikov',
      email: 'example@example.com',
      password: '1234567'
    }
  end
  let(:invalid_params) do
    {
      name: nil,
      surname: nil,
      email: nil,
      password: nil
    }
  end

  describe 'DELETE #destroy' do
    it 'redirect to root' do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST #create' do
    context 'when invalid' do
      it 'returns a successful response' do
        post :create, params: { session: invalid_params }
        expect(response).to be_successful
      end
    end
  end
end

# rubocop:enable all
