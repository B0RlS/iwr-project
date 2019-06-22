FactoryBot.define do
  factory :vacancy_attribute, class: 'Vacancy::Attribute' do
    attr_type { 'Test' }
    name { 'T' }
    association :vacancy, factory: :vacancy
  end
end
