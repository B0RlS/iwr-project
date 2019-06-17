# rubocop:disable all

require 'rails_helper'

RSpec.describe User::SkillLevelsController, type: :controller do
  let(:user) { User.create(user_params) }
  let(:skill) { Skill.create(skill_params) }
  let(:user_skill_level) { User::SkillLevel.create(valid_params) }
  let(:valid_params) do
    {
      skill_id: skill.id,
      user_id: user.id,
      level: 1
    }
  end
  let(:user_params) do
    {
      name: 'TestName',
      surname: 'TestSurname',
      email: 'test@example.com',
      password: '1234567'
    }
  end
  let(:skill_params) do
    {
      name: 'asdfas',
      sphere: 'asdfas'
    }
  end

  describe 'GET #edit' do
    before do
      log_in user
    end
    it 'returns a successful response' do
      get :edit, params: { user_id: user_skill_level.user_id }
      expect(response).to be_successful
    end

    it 'renders user_skill_levels#edit template' do
      get :edit, params: { user_id: user_skill_level.user_id }
      expect(response).to render_template(:edit)
    end
  end
end
