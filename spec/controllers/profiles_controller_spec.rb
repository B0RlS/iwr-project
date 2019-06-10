# rubocop:disable all
require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user, :with_profile) }
  let(:user2) { create(:user, :with_profile, email: 'test2@example.com') }

  describe 'GET #show' do
    context 'when logged in' do
      before do
        log_in user
      end
      it 'returns a successful response' do
        get :show, params: { id: user.profile.id }
        expect(response).to be_successful
      end

      it 'render profiles#show template' do
        get :show, params: { id: user.profile.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        get :show, params: { id: user.profile.id }
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
        get :edit, params: { id: user.profile.id }
        expect(response).to be_successful
      end

      it 'render profiles#edit template' do
        get :edit, params: { id: user.profile.id }
        expect(response).to render_template(:edit)
      end

      context 'when the user tries to change not his profile' do
        it 'redirect to root' do
          get :edit, params: { id: user2.profile.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        get :edit, params: { id: user.profile.id }
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
          patch :update, params: { id: user.profile.id,
                profile: valid_attribute }
          expect(user.profile.reload.telephone).to eq('375292222222')
        end

        it 'redirect to profile' do
          patch :update, params: { id: user.profile.id,
                profile: valid_attribute }
          expect(response).to redirect_to(profile_path(user.profile.id))
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { id: user.profile.id,
                profile: invalid_attribute }
          expect(user.profile.reload.telephone).to eq('375291111111')
        end
      end
    end

    context 'when the user tries to change not his profile' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { id: user2.profile.id,
              profile: valid_attribute }
        expect(user2.profile.reload.telephone).to eq('375291111111')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { id: user2.profile.id,
              profile: valid_attribute }
        expect(user2.profile.reload.telephone).to eq('375291111111')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
# rubocop:enable all
