require 'rails_helper'

RSpec.describe DirectorsController, type: :controller do
  let(:director) { create(:user, :as_director) }
  let(:user) { create(:user, email: 't@example.com') }
  let(:valid_attributes) do
    {
      user_id: user.id,
      user: {role: 'manager'}
    }
  end

  describe 'GET #show' do
    context 'when logged out' do
      it 'redirects to root' do
        get :show
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in' do
      context 'as user' do
        before do
          log_in user
        end

        it 'redirects to root' do
          get :show
          expect(response).to redirect_to(root_path)
        end
      end

      context 'as director' do
        before do
          log_in director
        end

        it 'renders view' do
          get :show
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'when logged out' do
      it "doesn't update user" do
        patch :update, params: valid_attributes
        expect(user.reload.role).to eq('employee')
      end

      it 'redirects to root' do
        patch :update, params: valid_attributes
        expect(response).to redirect_to root_path
      end
    end

    context 'when logged in' do
      context 'as user' do
        before do
          log_in user
        end

        it "doesn't update user" do
          patch :update, params: valid_attributes
          expect(user.reload.role).to eq('employee')
        end

        it 'redirects to root' do
          patch :update, params: valid_attributes
          expect(response).to redirect_to root_path
        end
      end

      context 'as director' do
        before do
          log_in director
        end

        it 'updates user' do
          patch :update, params: valid_attributes
          expect(user.reload.role).to eq('manager')
        end
      end
    end
  end
end
