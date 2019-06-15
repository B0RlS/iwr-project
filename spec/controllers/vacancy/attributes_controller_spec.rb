require 'rails_helper'

RSpec.describe Vacancy::AttributesController, type: :controller do
  let(:vacancy) { create(:vacancy) }
  let!(:vacancy_attribute) { create(:vacancy_attribute, vacancy: vacancy) }
  let(:vacancy2) { create(:vacancy, user: user2) }
  let!(:vacancy_attribute2) { create(:vacancy_attribute, vacancy: vacancy2) }
  let(:user2) { create(:user, email: 'example2@example.com') }

  describe 'POST #create' do
    let(:valid_params) do
      {
        name: 'T' * 10,
        attr_type: 'Test',
        vacancy_id: vacancy.id
      }
    end
    let(:invalid_params) do
      {
        name: nil,
        attr_type: nil,
        vacancy_id: vacancy.id
      }
    end

    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      context 'when valid' do
        it 'creates the record in the database' do
          expect do
            post :create, params: { vacancy_attribute: valid_params }
          end.to change(Vacancy::Attribute, :count).by(1)
        end
      end

      context 'when invalid' do
        it 'does not create a record in the database' do
          expect do
            post :create, params: { vacancy_attribute: invalid_params }
          end.not_to change(Vacancy::Attribute, :count)
        end

        it 'returns a successful response' do
          post :create, params: { vacancy_attribute: invalid_params }
          expect(response).to be_successful
        end
      end

      context 'when the user tries to create attribute not for his vacancy' do
        let(:valid_params) do
          {
            name: 'T' * 10,
            attr_type: 'Test',
            vacancy_id: vacancy2.id
          }
        end

        it 'does not create a record in the database' do
          expect do
            post :create, params: { vacancy_attribute: valid_params }
          end.not_to change(Vacancy::Attribute, :count)
        end

        it 'redirect to root' do
          post :create, params: { vacancy_attribute: valid_params }
          expect(response).to redirect_to(root_path)
        end
      end
    end
    context 'when logged out' do
      it 'redirect to root' do
        post :create, params: { vacancy_attribute: valid_params }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when logged in' do
      before do
        log_in vacancy.user
      end
      it 'returns a successful response' do
        get :edit, params: { attr_id: vacancy_attribute.id }
        expect(response).to be_successful
      end

      it 'rednder vacancy_attributes#edit template' do
        get :edit, params: { attr_id: vacancy_attribute.id }
        expect(response).to render_template(:edit)
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        get :edit, params: { attr_id: vacancy_attribute.id }
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
          patch :update, params: { attr_id: vacancy_attribute.id,
                vacancy_attribute: attributes_for(:vacancy, name: ('K' * 5)) }
          expect(vacancy_attribute.reload.name).to eq('K' * 5)
        end

        it 'redirect to vacancy' do
          patch :update, params: { attr_id: vacancy_attribute.id,
                vacancy_attribute: attributes_for(:vacancy, name: ('K' * 5)) }
          expect(response).to redirect_to(vacancy_path(vacancy.id))
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { attr_id: vacancy_attribute.id,
                vacancy_attribute: attributes_for(:vacancy, name: nil) }
          expect(vacancy_attribute.reload.name).to eq('T')
        end
        it 'render vacancy_attributes#edit template' do
          patch :update, params: { attr_id: vacancy_attribute.id,
                vacancy_attribute: attributes_for(:vacancy, name: nil) }
          expect(response).to render_template(:edit)
        end
      end

      context 'when the user tries to change not his vacancy attribute' do
        it 'does not update the record in the database' do
          patch :update, params: { attr_id: vacancy_attribute2.id,
                vacancy_attribute: attributes_for(:vacancy, name: ('K' * 5)) }
          expect(vacancy_attribute.reload.name).to eq('T')
        end

        it 'redirect to root' do
          patch :update, params: { attr_id: vacancy_attribute2.id,
                vacancy_attribute: attributes_for(:vacancy, name: ('K' * 5)) }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        patch :update, params: { attr_id: vacancy_attribute.id,
              vacancy_attribute: attributes_for(:vacancy, name: ('K' * 5)) }
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
          delete :destroy, params: { attr_id: vacancy_attribute.id }
        end.to change(Vacancy::Attribute, :count).by(-1)
      end

      context 'when the user tries to delete not his vacancy attribute' do
        it 'does not deletes the record from the database' do
          expect do
            delete :destroy, params: { attr_id: vacancy_attribute2.id }
          end.not_to change(Vacancy::Attribute, :count)
        end
      end
    end

    context 'when logged out' do
      it 'does not deletes the record from the database' do
        expect {
          delete :destroy, params: { attr_id: vacancy_attribute.id }
        }.not_to change(Vacancy::Attribute, :count)
      end

      it 'redirect to root' do
        delete :destroy, params: { attr_id: vacancy_attribute.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
