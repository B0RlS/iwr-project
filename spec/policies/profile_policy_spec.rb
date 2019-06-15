require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { described_class }
  let(:user) { create(:user, :with_profile) }

  context 'being a visitor' do
    permissions :update?, :edit? do
      it "denied access" do
        expect(subject).not_to permit(User.new, Profile.new)
      end
    end
  end

  context 'being a user' do
    permissions :update?, :edit? do
      context 'if user is trying to change his profile' do
        it "allowed access" do
          expect(subject).to permit(user, user.profile)
        end
      end

      context 'if user is trying to change not his account' do
        it "denies access" do
          expect(subject).not_to permit(user, Profile.new)
        end
      end
    end
  end
end
