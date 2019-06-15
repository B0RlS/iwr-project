require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }
  let(:user) { create(:user) }

  context 'being a visitor' do
    permissions :update?, :edit?, :destroy? do
      it "denied access" do
        expect(subject).not_to permit(User.new, User.new)
      end
    end
  end

  context 'being a user' do
    permissions :update?, :edit?, :destroy? do
      context 'if user is trying to change his account' do
        it "allowed access" do
          expect(subject).to permit(user, user)
        end
      end

      context 'if user is trying to change not his account' do
        it "denies access" do
          expect(subject).not_to permit(user, User.new)
        end
      end
    end
  end
end
