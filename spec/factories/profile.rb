# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    telephone { '375291111111' }
    country_code { :BY }
    city { 'Minsk' }
    birthday { '22.01.2019' }
    user
  end
end
