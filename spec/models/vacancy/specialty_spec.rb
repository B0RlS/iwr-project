require 'rails_helper'

RSpec.describe Vacancy::Specialty, type: :model do
  it { should have_many(:vacancies) }
end
