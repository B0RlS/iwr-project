FactoryBot.define do
  factory :user do
    name { 'TestName' }
    surname { 'TestSurname' }
    email { 'test@example.com' }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :with_profile do
      after :create do |user|
        create :profile, user: user
      end
    end

    trait :with_education do
      after :create do |user|
        create :education, user: user
      end
    end
    
    trait :with_skills do
      after :create do |user|
        create :skill_levels, user: user, skill: (create :skill)
      end
    end
  end
end
