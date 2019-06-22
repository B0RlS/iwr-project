FactoryBot.define do
  factory :vacancy do
    name { 'T' * 10 }
    description { 'T' * 50 }
    country { 'Belarus' }
    city { 'Minsk' }
    association :user, factory: :user
    association :specialty, factory: :vacancy_specialty
  end
end
