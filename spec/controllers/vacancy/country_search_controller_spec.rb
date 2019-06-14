require 'rails_helper'

RSpec.describe Vacancy::CountrySearchController, type: :controller do
  describe 'GET #index' do
    context 'when logged in' do
      before do
        log_in create(:user)
      end
      it 'render index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when logged out' do
      it 'returns to root' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
