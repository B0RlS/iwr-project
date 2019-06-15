# frozen_string_literal: true

module Authenticatable
  include ActiveSupport::Concern
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = if BCrypt::Engine::MIN_COST
             ActiveModel::SecurePassword.min_cost
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_digest = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
