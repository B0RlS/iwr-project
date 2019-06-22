require 'rails_helper'

RSpec.describe Vacancy::PublishController, type: :controller do
  let(:vacancy) { create(:vacancy) }
  let(:vacancy2) { create(:vacancy, user: user2) }
  let(:user2) { create(:user, email: 'example2@example.com') }

  describe 'PATCH #update' do
    context 'when loggin in' do
      before do
        log_in vacancy.user
      end

      it 'updates the record in the database' do
        patch :update, params: { vac_id: vacancy.id, publish: true }
        expect(vacancy.reload.publish).to eq(true)
      end

      context 'when the user tries to change not his vacancy' do
        it 'does not update the record in the database ' do
          patch :update, params: { vac_id: vacancy2.id, publish: true }
          expect(vacancy.reload.publish).to eq(false)
        end
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database ' do
        patch :update, params: { vac_id: vacancy.id, publish: true }
        expect(vacancy.reload.publish).to eq(false)
      end

      it 'redirect to root' do
        patch :update, params: { vac_id: vacancy.id, publish: true }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
