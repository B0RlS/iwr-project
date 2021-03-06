require 'rails_helper'

RSpec.describe UserCreateService do
  subject { UserCreateService.new(user_params) }
  let(:user_params) do
    {
      name: 'TestName',
      surname: 'TestSurname',
      email: 'test@example.com',
      password: '1234567'
    }
  end
  describe '#call' do
    it 'create User' do
      expect { subject.call }.to change { User.all.count }.by(1)
    end
    it 'create Education with no validation' do
      expect { subject.call }.to change { User::Education.all.count }.by(1)
    end
    it 'create Profile with no validation' do
      expect { subject.call }.to change { Profile.all.count }.by(1)
    end
  end
end
