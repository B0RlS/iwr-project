require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }
  let(:user) { create(:user) }
  let(:admin) { create(:user, :as_admin, email: 't@example.com')}
  let(:director) { create(:user, :as_director, email: 'd@example.com')}

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
        it "allows access" do
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
  
  context 'being an admin' do
    permissions :update?, :edit?, :destroy?, :show? do
      context 'if admin tryes to change accounts' do
        it 'allows access' do
          expect(subject).to permit(admin, user)
        end
      end
    end
  end

  context 'being a director' do
    permissions :update?, :show? do
      context 'if director tryes to change accounts' do
        it 'allows access' do
          expect(subject).to permit(director, user)
        end
      end
    end
  end
end
