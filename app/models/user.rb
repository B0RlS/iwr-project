# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticatable
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  has_one :profile, dependent: :destroy
  has_one :education, dependent: :destroy, class_name: 'User::Education'
  has_many :vacancies, dependent: :destroy
  has_many :vacancy_requests, class_name: 'Vacancy::Request'

  has_many :skill_levels, dependent: :destroy,
                          class_name: 'User::SkillLevel'
  has_many :skills, through: :skill_levels

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :surname, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, length: { minimum: 8, maximum: 200 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true,
                       length: { minimum: 6, maximum: 200 },
                       allow_nil: true

  enum role: %i[employee admin manager director]
  after_initialize :set_default_role, if: :new_record?
  validates :password_confirmation, presence: true,
                                    length: { minimum: 6, maximum: 200 },
                                    allow_nil: true

  accepts_nested_attributes_for :skill_levels,
                                reject_if: :blank

  def set_default_role
    self.role ||= :employee
  end

  def blank(attributes)
    attributes['level'].blank?
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
