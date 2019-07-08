require 'rails_helper'

RSpec.describe ManagersController, type: :controller do
  let(:manager) { create(:user, :as_manager) }
  let(:user) { create(:user) }

  describe 'GET #show' do
    context 'when logged in' do
      before do
        log_in manager
      end
      it 'returns a successful response' do
        get :show
        expect(response).to be_successful
      end

      it 'render manager#show template' do
        get :show
        expect(response).to render_template(:show)
      end
    end

    context 'when logged out' do
      it 'redirect to root page' do
        get :show
        expect(response).to redirect_to(root_path)
      end
    end
  end
end