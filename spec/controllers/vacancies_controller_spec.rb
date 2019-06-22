require 'rails_helper'

RSpec.describe VacanciesController, type: :controller do
  let(:vacancy) { create :vacancy }
  let(:user2) { create :user, email: 'example2@gmail.com'}
  let!(:vacancy2) { create :vacancy, user: user2 }

  describe 'GET #index' do
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'render vacancy#index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end
    context 'when logged out' do
      it 'redirect to root page' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      it 'returns a successful response' do
        get :show, params: { vac_id: vacancy.id }
        expect(response).to be_successful
      end

      it 'render vacancy#show template' do
        get :show, params: { vac_id: vacancy.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when logged out' do
      it 'redirect to root page' do
        get :show, params: { vac_id: vacancy.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      it 'returns a successful response' do
        get :new
        expect(response).to be_successful
      end

      it 'render vacancy#new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when logged out' do
      it 'redirect to root page' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        name: 'T' * 10,
        description: 'T' * 50,
        country: :BY,
        city: 'Minsk',
        specialty_id: vacancy.specialty_id,
        user_id: vacancy.user_id
      }
    end
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      context 'when valid' do
        it 'redirect to vacancy' do
          post :create, params: { vacancy: valid_params }
          expect(response).to redirect_to(vacancy_path(assigns(:vacancy)))
        end

        it 'creates the record in the database' do
          expect do
            post :create, params: { vacancy: valid_params }
          end.to change(Vacancy, :count).by(1)
        end
      end

      context 'when invalid' do
        it 'render vacancy#new template' do
          post :create, params: { vacancy: attributes_for(:vacancy) }
          expect(response).to render_template(:new)
        end

        it 'does not create a record in the database' do
          expect do
            post :create, params: { vacancy: attributes_for(:vacancy) }
          end.not_to change(Vacancy, :count)
        end

        it 'returns a successful response' do
          post :create, params: { vacancy: attributes_for(:vacancy) }
          expect(response).to be_successful
        end
      end
    end

    context 'when logged out' do
      it 'redirect to root path' do
        post :create, params: { vacancy: valid_params }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      context 'with valid params' do
        it 'updates the record in the database' do
          patch :update, params: { vac_id: vacancy.id, vacancy: attributes_for(:vacancy, name: ('B' * 10)) }
          expect(vacancy.reload.name).to eq('B' * 10)
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { vac_id: vacancy.id, vacancy: attributes_for(:vacancy, name: nil) }
          expect(vacancy.reload.name).to eq('T' * 10)
        end
      end

      context 'when the user tries to change not his vacancy' do
        it 'does not update the record in the database and redirect to root' do
          patch :update, params: { vac_id: vacancy2.id, vacancy: attributes_for(:vacancy, name: ('B' * 10)) }
          expect(vacancy2.reload.name).to eq('T' * 10)
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when logged out' do
      it 'redirect to root path' do
        patch :update, params: { vac_id: vacancy.id, vacancy: attributes_for(:vacancy, name: ('B' * 10)) }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      it 'deletes the record from the database' do
        expect do
          delete :destroy, params: { vac_id: vacancy.id }
        end.to change(Vacancy, :count).by(-1)
      end

      it 'redirect to root' do
        delete :destroy, params: { vac_id: vacancy.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user tries to delete not his vacancy' do
      it 'does not delete the record in the database' do
        expect do
          delete :destroy, params: { vac_id: vacancy2.id }
        end.not_to change(Vacancy, :count)
      end

      it 'redirect to root' do
        delete :destroy, params: { vac_id: vacancy2.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'when logged out' do
    it 'redirect to root_path' do
      delete :destroy, params: { vac_id: vacancy.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
