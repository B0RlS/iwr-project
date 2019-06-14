require 'rails_helper'

RSpec.describe ProfileCreateService do
  subject { ProfileCreateService.new(user_id: user.id) }
  let(:user) { create(:user) }

  describe '#call!' do
    it 'create Profile with no validation' do
      expect{ subject.call! }.to change{ Profile.all.count }.by(1)
    end
  end
end
