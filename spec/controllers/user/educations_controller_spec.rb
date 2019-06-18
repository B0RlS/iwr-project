require 'rails_helper'

RSpec.describe User::EducationsController, type: :controller do
  let(:user) { create(:user, :with_education) }

  describe 'GET #edit' do
    context 'when logged in' do
      before do
        log_in user
      end
      it 'returns a successful response' do
        get :edit, params: { user_id: user.education.id }
        expect(response).to be_successful
      end

      it 'renders educations#edit template' do
        get :edit, params: { user_id: user.education.id }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PUT #update' do
    before do
      log_in user
    end
    let(:valid_attribute) do
      {
        faculty: 'IEF'
      }
    end
    let(:invalid_attribute) do
      {
        faculty: 'F'
      }
    end
    context 'with valid parameters' do
      it 'updates the record in the database' do
        put :update, params: { user_id: user.education.id, user_education: valid_attribute }
        expect(user.education.reload.faculty).to eq('IEF')
      end

      it 'redirects to profile' do
        put :update, params: { user_id: user.education.id, user_education: valid_attribute }
        expect(response).to redirect_to(profile_path(current_user))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the record in the database' do
        put :update, params: { user_id: user.education.id, user_education: invalid_attribute }
        expect(user.education.reload.faculty).to eq('FKSIS')
      end
      it 'renders educations#edit template' do
        put :update, params: { user_id: user.education.id, user_education: invalid_attribute }
        expect(response).to render_template(:edit)
      end
    end
  end
end
