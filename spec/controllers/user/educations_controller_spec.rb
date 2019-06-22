require 'rails_helper'

RSpec.describe User::EducationsController, type: :controller do
  let(:user) { create(:user, :with_education) }

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
  end
end
