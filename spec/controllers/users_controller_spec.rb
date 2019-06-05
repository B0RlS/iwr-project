# frozen_string_literal: true
# rubocop:disable all

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(valid_params) }
  let!(:user2) { User.create(user2_params) }
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
  let(:user2_params) do
    {
      name: 'TestName',
      surname: 'TestSurname',
      email: 'test@example.com',
      password: '1234567'
    }
  end
  let(:profile_params) do
    {
      telephone: '375291111111',
      country_code: 'BY',
      city: 'Minsk',
      birthday: '25.01.2017',
      user_id: user.id
    }
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'creates the record in the database' do
        expect do
          post :create, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end

      it 'redirect to root' do
        post :create, params: { user: valid_params }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when invalid' do
      it 'does not create a record in the database' do
        expect do
          post :create, params: { user: invalid_params }
        end.not_to change(User, :count)
      end

      it 'returns a successful response' do
        post :create, params: { user: invalid_params }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    let!(:profile) { Profile.create(profile_params) }
    let(:valid_attribute) do
      {
        name: 'Pepega'
      }
    end
    let(:invalid_attribute) do
      {
        name: 'P'
      }
    end

    context 'when logged in' do
      before do
        log_in user
      end

      context 'with valid params' do
        it 'updates the record in the database' do
          patch :update, params: { user_id: user.id, user: valid_attribute }
          expect(user.reload.name).to eq('Pepega')
        end

        it 'redirect to profile' do
          patch :update, params: { user_id: user.id, user: valid_attribute }
          expect(response).to redirect_to(profile_path(profile.id))
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { user_id: user.id, user: invalid_attribute }
          expect(user.reload.name).to eq('Boris')
        end
      end

      context 'when the user tries to change not his account' do
        it 'does not update the record in the database and redirect to root' do
          patch :update, params: { user_id: user2.id, user: valid_attribute }
          expect(user.reload.name).to eq('Boris')
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { user_id: user.id, user: valid_attribute }
        expect(user.reload.name).to eq('Boris')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      before do
        log_in user
      end
      it 'deletes the record from the database' do
        expect {
          delete :destroy, params: { user_id: user.id }
        }.to change(User, :count).by(-1)
      end

      context 'when the user tries to delete not his account' do
        it 'does not deletes the record from the database' do
          expect {
            delete :destroy, params: { user_id: user2.id }
          }.not_to change(User, :count)
        end
      end
    end

    context 'when logged out' do
      it 'does not deletes the record from the database' do
        expect {
          delete :destroy, params: { user_id: user2.id }
        }.not_to change(User, :count)
      end

      it 'redirect to root' do
        delete :destroy , params: { user_id: user2.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

# rubocop:enable all
