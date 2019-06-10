# rubocop:disable all
require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when user login' do
      before do
        log_in create(:user)
      end
      it 'render application layout' do
        get :index
        expect(response).to render_template(layout: 'application')
      end
    end

    context 'when user is not authorized' do
      it 'render welcome layout' do
        get :index
        expect(response).to render_template(layout: 'welcome')
      end
    end
  end
end
# rubocop:enable all
