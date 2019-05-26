require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:profile) { Profile.create(valid_params)}
  let(:valid_params) do
    {
      telephone: '375291111111',
      country_code: 'BY',
      city: 'Minsk',
      birthday: '25.01.2017'
    }
  end
  let(:invalid_params) do
    {
      telephone: nil,
      country_code: nil,
      city: nil,
      birthday: nil
    }
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: profile.id }
      expect(response).to be_successful
    end

    it 'render profiles#show template' do
      get :show, params: { id: profile.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'render profiles#new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'redirect to profile' do
        post :create, params: { profile: valid_params }
        expect(response).to redirect_to(profile_path(assigns(:profile)))
      end

      it 'creates the record in the database' do
        expect {
          post :create, params: { profile: valid_params }
        }.to change(Profile, :count).by(1)
      end
    end

    context 'when invalid' do
      it 'render profiles#new template' do
        post :create, params: { profile: invalid_params }
        expect(response).to render_template(:new)
      end

      it 'does not create a record in the database' do
        expect {
          post :create, params: { profile: invalid_params }
        }.not_to change(Profile, :count)
      end

      it 'returns a successful response' do
        post :create, params: { profile: invalid_params }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: profile.id }
      expect(response).to be_successful
    end

    it 'rednder profiles#edit template' do
      get :edit, params: { id: profile.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let(:valid_attribute) do
      {
        telephone: '375292222222'
      }
    end
    let(:invalid_attribute) do
      {
        telephone: '1'
      }
    end
    context 'with valid params' do
      it 'updates the record in the database' do
        put :update, params: { id: profile.id, profile: valid_attribute }
        expect(profile.reload.telephone).to eq('375292222222')
      end

      it 'redirect to profile' do
        put :update, params: { id: profile.id, profile: valid_attribute }
        expect(response).to redirect_to(profile_path(profile.id))
      end
    end

    context 'with invalid params' do
      it 'does not update the record in the database' do
        put :update, params: { id: profile.id, profile: invalid_attribute }
        expect(profile.reload.telephone).to eq('375291111111')
      end
      it 'render profiles#edit template' do
        put :update, params: { id: profile.id, profile: invalid_attribute }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it "deletes the record from the database" do
      expect {
        delete :destroy, params: { id: profile.id }
      }.to change(Profile, :count).by(-1)
    end

    it 'redirect to root' do
      delete :destroy, params: { id: profile.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
