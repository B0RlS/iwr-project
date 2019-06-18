require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
	let(:user) { create(:user, :with_profile, :with_education) }
	let(:user_skill_level) { create(:user_skill_levels, :with_dependance) }
  let(:user2) { create(:user, :with_profile, email: 'test2@example.com') }

  describe 'GET #show' do
    context 'when logged in' do
      before do
        log_in user
      end
      it 'returns a successful response' do
        get :show, params: { user_id: user.profile.id }
        expect(response).to be_successful
      end

      it 'render profiles#show template' do
        get :show, params: { user_id: user.profile.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when logged out' do
      it 'redirect to root' do
        get :show, params: { user_id: user.profile.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

	describe 'PATCH #update' do
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
    let(:valid_avatar) do
      {
          avatar: fixture_file_upload(Rails.root.
              join('spec', 'fixtures' , 'files', 'test_valid_avatar.png'), 'image/png')
      }
    end
    let(:valid_resume) do
      {
          resume: fixture_file_upload(Rails.root.
              join('spec', 'fixtures' , 'files', 'test_valid_resume.pdf'), 'application/pdf')
      }
    end
		context 'when logged in' do
			before do
				log_in user
			end
			context 'with valid params' do
				it 'updates the record in the database' do
					patch :update, params: { user_id: user.profile.id, profile: valid_attribute }
					expect(user.profile.reload.telephone).to eq('375292222222')
				end
			end
		end

    context 'when logged in' do
      before do
        log_in user
      end
      context 'with valid params' do
        it 'updates the record in the database' do
          patch :update, params: { user_id: user.profile.id,
                profile: valid_attribute }
          expect(user.profile.reload.telephone).to eq('375292222222')
        end

        it 'redirect to profile' do
          patch :update, params: { user_id: user.profile.id,
                profile: valid_attribute }
          expect(response).to redirect_to(profile_path(user.profile.id))
        end
      end

      context 'with invalid params' do
        it 'does not update the record in the database' do
          patch :update, params: { user_id: user.profile.id,
                profile: invalid_attribute }
          expect(user.profile.reload.telephone).to eq('375291111111')
        end
      end


      context 'when a user tries to change his avatar' do
        it 'attaches the uploaded valid file' do
          expect {
            patch :update, params: { user_id: user.profile.id, profile: valid_avatar }
          }.to change(ActiveStorage::Attachment, :count).by(1)
        end
      end

      context 'when a user tries to change his resume' do
        it 'attaches the uploaded valid resume' do
          expect {
            patch :update, params: { user_id: user.profile.id, profile: valid_resume }
          }.to change(ActiveStorage::Attachment, :count).by(1)
        end
      end
    end

    context 'when the user tries to change not his profile' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { user_id: user2.profile.id,
              profile: valid_attribute }
        expect(user2.profile.reload.telephone).to eq('375291111111')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged out' do
      it 'does not update the record in the database and redirect to root' do
        patch :update, params: { user_id: user2.profile.id,
              profile: valid_attribute }
        expect(user2.profile.reload.telephone).to eq('375291111111')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
