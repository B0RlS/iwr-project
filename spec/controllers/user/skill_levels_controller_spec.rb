# rubocop:disable all

require 'rails_helper'

RSpec.describe User::SkillLevelsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #edit' do
    before do
      log_in user
    end
    it 'returns a successful response' do
      get :edit, params: { user_id: user.id }
      expect(response).to be_successful
    end

    it 'renders user_skill_levels#edit template' do
      get :edit, params: { user_id: user.id }
      expect(response).to render_template(:edit)
    end
  end
end
