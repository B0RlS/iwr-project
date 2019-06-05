# frozen_string_literal: true
# rubocop:disable all
require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { User.create(user_params) }
  let(:user2) { User.create(user2_params) }
  let(:profile) { Profile.create(valid_params) }
  let(:profile2) { Profile.create(valid_params2) }
  let(:valid_params) do
    {
      telephone: '375291111111',
      country_code: 'BY',
      city: 'Minsk',
      birthday: '25.01.2017',
      user_id: user.id
    }
  end
  let(:valid_params2) do
    {
      telephone: '375291111111',
      country_code: 'BY',
      city: 'Minsk',
      birthday: '25.01.2017',
      user_id: user2.id
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
  let(:user2_params) do
    {
      name: 'TestName2',
      surname: 'TestSurname2',
      email: 'test2@example.com',
      password: '1234567'
    }
  end

  describe 'GET #show' do
    context 'when logged in' do
      before do
        log_in user
      end
      it 'returns a successful response' do
        get :show, params: { id: profile.id }
        expect(response).to be_successful
      end

      it 'render profiles#show template' do
        get :show, params: { id: profile.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        get :show, params: { id: profile.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when logged in' do
      before do
        log_in user
      end
      it 'returns a successful response' do
        get :edit, params: { id: profile.id }
        expect(response).to be_successful
      end

      it 'render profiles#edit template' do
        get :edit, params: { id: profile.id }
        expect(response).to render_template(:edit)
      end

      context 'when the user tries to change not his profile' do
        it 'redirect to root' do
          get :edit, params: { id: profile2.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        get :edit, params: { id: profile.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
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

    context 'when logged in' do
      before do
        log_in user
      end
      context 'with valid params' do
        it 'updates the record in the database' do
          patch :update, params: { id: profile.id, profile: valid_attribute }
          expect(profile.reload.telephone).to eq('375292222222')
        end

        it 'redirect to profile' do
          patch :update, params: { id: profile.id, profile: valid_attribute }
          expect(response).to redirect_to(profile_path(profile.id))
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { id: profile.id, profile: invalid_attribute }
          expect(profile.reload.telephone).to eq('375291111111')
        end
      end
    end

    context 'when the user tries to change not his profile' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { id: profile2.id, profile: valid_attribute }
        expect(profile.reload.telephone).to eq('375291111111')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { id: profile2.id, profile: valid_attribute }
        expect(profile.reload.telephone).to eq('375291111111')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
# rubocop:enable all
