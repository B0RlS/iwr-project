# rubocop:disable all

require 'rails_helper'
include SessionsHelper

RSpec.describe ProfilePolicy do
  subject { described_class }
  let(:user) { User.create(user_params) }
  let(:user_params) do
    {
      name: 'TestName',
      surname: 'TestSurname',
      email: 'example@example.com',
      password: '1234567',
      password_confirmation: '1234567'
    }
  end
  let(:profile_params) do
    {
      telephone: '375291111111',
      country_code: 'BY',
      city: 'Minsk',
      birthday: '25.01.2017',
      user_id: user.id
    }
  end

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
          expect(subject).to permit(user, Profile.create(profile_params))
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
# rubocop:enable all
