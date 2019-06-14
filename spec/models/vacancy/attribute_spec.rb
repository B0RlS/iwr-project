require 'rails_helper'

RSpec.describe Vacancy::Attribute, type: :model do
  it { should belong_to(:vacancy) }

  describe '#name' do
    it { should validate_presence_of(:name) }
  end

  describe '#attr_type' do
    it { should validate_presence_of(:attr_type) }
  end
end
