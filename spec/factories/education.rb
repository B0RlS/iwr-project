FactoryBot.define do
  factory :education, class: User::Education do
    university { 'BSUIR' }
    faculty { 'FKSIS' }
    department { 'VMSIS' }
    entrance_year { '2016' }
    graduation_year { '2020' }
    english_level { 'A1' }
    user
  end
end
