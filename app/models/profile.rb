# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  validates :telephone, presence: true, numericality: true,
                        length: { minimum: 10, maximum: 15 }
  validates :country_code, presence: true,
                           length: { minimum: 2, maximum: 2 }
  validates :city, presence: true, length: { minimum: 3, maximum: 20 }
  validates :birthday, presence: true
  validates :avatar, content_type: %w[image/png image/jpg image/jpeg],
                     dimension: { width: { min: 80, max: 3000 },
                                  height: { min: 80, max: 3000 },
                                  message: 'is not given between dimension' },
                     size: { less_than: 100.megabytes,
                             message: 'is not given between size' }

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
