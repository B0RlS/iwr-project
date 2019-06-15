# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :telephone, presence: true, numericality: true,
                        length: { minimum: 10, maximum: 15 }
  validates :country_code, presence: true,
                           length: { minimum: 2, maximum: 2 }
  validates :city, presence: true, length: { minimum: 3, maximum: 20 }
  validates :birthday, presence: true

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name unless
        country_code.nil?
  end

  def user_name
    user.name
  end

  def user_surname
    user.surname
  end

  def user_birthday
    birthday
  end

  def user_email
    user.email
  end
end
