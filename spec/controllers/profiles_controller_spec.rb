# frozen_string_literal: true
# rubocop:disable all
require 'rails_helper'
include SessionsHelper

RSpec.describe ProfilesController, type: :controller do
  let(:user) { User.create(user_params) }
  let(:profile) { Profile.create(valid_params) }
  let(:valid_params) do
    {
      telephone: '375291111111',
      country_code: 'BY',
      city: 'Minsk',
      birthday: '25.01.2017',
      user_id: user.id
    }
  end
  let(:invalid_params) do
    {
      telephone: nil,
      country_code: nil,
      city: nil,
      birthday: nil
    }
  end
  let(:user_params) do
    {
      name: 'TestName',
      surname: 'TestSurname',
      email: 'test@example.com',
      password: '1234567'
    }
  end

  before(:each) do
    log_in user
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: profile.id }
      expect(response).to be_successful
    end

    it 'render profiles#show template' do
      get :show, params: { id: profile.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: profile.id }
      expect(response).to be_successful
    end

    it 'render profiles#edit template' do
      get :edit, params: { id: profile.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let(:valid_attribute) do
      {
        telephone: '375292222222'
      }
    end
    let(:invalid_attribute) do
      {
        telephone: '1'
      }
    end
    context 'with valid params' do
      it 'updates the record in the database' do
        put :update, params: { id: profile.id, profile: valid_attribute }
        expect(profile.reload.telephone).to eq('375292222222')
      end

      it 'redirect to profile' do
        put :update, params: { id: profile.id, profile: valid_attribute }
        expect(response).to redirect_to(profile_path(profile.id))
      end
    end

    context 'with invalid params' do
      it 'does not update the record in the database' do
        put :update, params: { id: profile.id, profile: invalid_attribute }
        expect(profile.reload.telephone).to eq('375291111111')
      end
      it 'render profiles#edit template' do
        put :update, params: { id: profile.id, profile: invalid_attribute }
        expect(response).to render_template(:edit)
      end
    end
  end
end

# rubocop:enable all
