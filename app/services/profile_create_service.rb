# frozen_string_literal: true

class ProfileCreateService
  attr_reader :user_id

  def initialize(params)
    @user_id = params[:user_id]
  end

  def call!
    save_profile!
  end

  private

  def save_profile!
    profile = Profile.new(user_id: user_id)
    profile.save(validate: false)
  end
end
