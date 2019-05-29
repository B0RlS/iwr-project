# frozen_string_literal: true
# rubocop:disable all

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(valid_params) }
  let(:valid_params) do
    {
      name: 'Boris',
      surname: 'Tsarikov',
      email: 'example@example.com',
      password: '1234567'
    }
  end
  let(:invalid_params) do
    {
      name: nil,
      surname: nil,
      email: nil,
      password: nil
    }
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'render users#show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'render users#new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'redirect to profile' do
        post :create, params: { user: valid_params }
        expect(response).to redirect_to(user_path(assigns(:user)))
      end

      it 'creates the record in the database' do
        expect do
          post :create, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end
    end

    context 'when invalid' do
      it 'render users#new template' do
        post :create, params: { user: invalid_params }
        expect(response).to render_template(:new)
      end

      it 'does not create a record in the database' do
        expect do
          post :create, params: { user: invalid_params }
        end.not_to change(User, :count)
      end

      it 'returns a successful response' do
        post :create, params: { user: invalid_params }
        expect(response).to be_successful
      end
    end
  end
end

# rubocop:enable all