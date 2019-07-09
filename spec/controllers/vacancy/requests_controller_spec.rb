require 'rails_helper'

RSpec.describe Vacancy::RequestsController, type: :controller do
  let(:vacancy) { create(:vacancy) }
  let(:user) { create(:user, email: "example2@example.com") }
  let(:manager) { create(:user, :as_manager, email: 'm@example.com') }

  describe 'GET #index' do
    context 'when logged in' do
      before do
        log_in user
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

  describe 'POST #create' do
    let(:valid_params) do
      {
        user_id: user.id,
        vacancy_id: vacancy.id
      }
    end
    let(:invalid_params) do
      {
        user_id: nil,
        vacancy_id: nil
      }
    end

    context 'when logged in' do
      before do
        log_in user
      end
      context 'when valid' do
        it 'redirect to vacancy' do
          post :create, params: { request: valid_params }
          expect(response).to redirect_to(vacancy_path(vacancy.id))
        end

        it 'creates the record in the database' do
          expect do
            post :create, params: { request: valid_params }
          end.to change(Vacancy::Request, :count).by(1)
        end
      end

      context 'when invalid' do
        it 'does not create a record in the database' do
          expect do
            post :create, params: { request: invalid_params }
          end.not_to change(Vacancy::Request, :count)
        end

        it 'redirect to root path' do
          post :create, params: { request: invalid_params }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when the user tries to create a request for his vacancy' do
        let(:vacancy2) { create(:vacancy, user: user) }

        it 'does not create a record in the database' do
          expect do
            post :create, params: { request: { vacancy_id: vacancy2.id,
                                              user_id: user.id } }
          end.not_to change(Vacancy::Request, :count)
        end
      end
    end

    context 'when logged out' do
      it "doesn't create request" do
        expect do
          post :create, params: { request: valid_params }
        end.not_to change(Vacancy::Request, :count)
      end

      it 'redirects to root path' do
        post :create, params: { request: valid_params }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when logged out' do
      it "doesn't update request" do

      end

      it 'redirects to root' do
      end
    end

    context 'when logged in' do
      context 'as user' do
        before do
          log_in user
        end

        it "doesn't update request" do
        end

        it 'redirects to root' do
        end
      end

      context 'as manager' do
        before do
          log_in manager
        end

        context 'with valid params' do
          it 'updates request' do
          end

          it 'redirects to vacancy' do
          end
        end

        context 'with invalid params' do
          it "doesn't update request" do
          end

          it 'redirects to vacancy' do
          end
        end
      end
    end
  end
end
