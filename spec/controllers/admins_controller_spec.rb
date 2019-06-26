require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:admin) { create(:user, :as_admin, email: 't@example.com') }
  let(:user) { create(:user) }
  let!(:user2) { create(:user, email: 'd@example.com') }

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

      context 'as admin' do
        before do
          log_in admin
        end

        it 'renders view' do
          get :show
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_attribute) do
      { role: :employee }
    end

    context 'when logged in' do
      context 'as non admin user' do
        before do
          log_in user
        end

        it "doesn't update users" do
          patch :update, params: { format: admin.id, user: valid_attribute }
          expect(admin.reload.role).not_to eq('employee')
        end
        
        it 'redirects to root' do
          patch :update, params: { format: admin.id, user: valid_attribute }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'as admin' do
        before do
          log_in admin
        end

        context 'with valid params' do
          it 'updates user' do
            patch :update, params: { format: admin.id, user: valid_attribute }
            expect(admin.reload.role).to eq('employee')
          end

          it 'redirects to admin path' do
            patch :update, params: { format: admin.id, user: valid_attribute }
            expect(response).to redirect_to(admin_path)
          end
        end
      end

      context 'with valid params' do
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database and redirects to root' do
        patch :update, params: { format: user.id, user: valid_attribute }
        expect(user.reload.role).to eq('employee')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      context 'as non admin user' do
        before do
          log_in user
        end

        it "doesn't delete the record from the db" do
          expect do
            delete :destroy, params: { format: user2.id }
          end.not_to change(User, :count)
        end

        it 'redirects to root' do
          delete :destroy, params: { format: user2.id }
          expect(response).to redirect_to(root_path)
        end
      end
      
      context 'as admin' do
        before do
          log_in admin
        end

        it 'deletes the record from the db' do
          expect do
            delete :destroy, params: { format: user2.id }
          end.to change(User, :count).by(-1)
        end
      end
    end

    context 'when logged out' do
      it "doesn't delete records from db" do
        expect {
          delete :destroy, params: { format: user2.id }
        }.not_to change(User, :count)
      end
    
      it 'redirects to root' do
        delete :destroy, params: { format: user2.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
