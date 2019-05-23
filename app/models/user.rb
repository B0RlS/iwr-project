class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { self.email = email.downcase}

  validates :name, presence: true, length: { minimum: 2, maximum: 30}
  validates :surname, presence: true, length: { minimum: 5, maximum: 50}
  validates :email, presence: true, length: { minimum: 10, maximum: 200},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }
end
