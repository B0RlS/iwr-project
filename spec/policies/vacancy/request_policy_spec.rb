require 'rails_helper'

RSpec.describe Vacancy::RequestPolicy do
  subject { described_class }
  let(:vacancy) { create(:vacancy) }
  let(:user) { create(:user, email: 'example2@example.com') }

  context 'being a visitor' do
    permissions :create? do
      it "denied access" do
        expect(subject).not_to permit(User.new, Vacancy::Request.new)
      end
    end
  end

  context 'being a user' do
    permissions :create? do
      context 'if user is trying to create a request' do
        it "allowed access" do
          expect(subject).to permit(user,
                 Vacancy::Request.new(vacancy_id: vacancy.id, user_id: user.id))
        end
      end
    end
  end
end
