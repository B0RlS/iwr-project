require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, :with_profile, :with_education) }
  let!(:user2) { create(:user, :with_profile, :with_education, email: 'test2@example.com') }
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

  describe 'GET #email_uniq?' do
    it 'has 404 status code if email uniq' do
      get :email_uniq?, params: { email: 'uniqemail@example.com' }
      expect(response).to have_http_status(404)
    end
    
    it 'has 204 status code if email not uniq' do
      get :email_uniq?, params: { email: user2.email }
      expect(response).to have_http_status(204)
    end
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

        it 'redirects to profile' do
          patch :update, params: { user_id: user.id, user: valid_attribute }
          expect(response).to redirect_to(profile_path(user.profile.id))
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { user_id: user.id, user: invalid_attribute }
          expect(user.reload.name).to eq('TestName')
        end
      end

      context 'when the user tries to change not his account' do
        it 'does not update the record in the database and redirects to root' do
          patch :update, params: { user_id: user2.id, user: valid_attribute }
          expect(user.reload.name).to eq('TestName')
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database and redirects to root' do
        patch :update, params: { user_id: user.id, user: valid_attribute }
        expect(user.reload.name).to eq('TestName')
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
        it 'does not delete the record from the database' do
          expect {
            delete :destroy, params: { user_id: user2.id }
          }.not_to change(User, :count)
        end
      end
    end

    context 'when logged out' do
      it 'does not delete the record from the database' do
        expect {
          delete :destroy, params: { user_id: user2.id }
        }.not_to change(User, :count)
      end

      it 'redirects to root' do
        delete :destroy , params: { user_id: user2.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
