# frozen_string_literal: true

class UserCreateService
  attr_reader :name, :surname, :email, :password, :password_confirmation, :role

  def initialize(params)
    @name = params[:name]
    @surname = params[:surname]
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @role = params[:role]
  end

  def call
    begin
      ActiveRecord::Base.transaction do
        save_user!
        save_profile!
        save_education!
      end
    rescue ActiveRecord::RecordInvalid => e
      puts e.message
    end
    @user
  end

  private

  def save_user!
    @user = User.new(name: name, surname: surname,
                     email: email, password: password,
                     password_confirmation: password_confirmation,
                     role: role)
    @user.save!
  end

  def save_profile!
    profile = Profile.new(user_id: @user.id)
    profile.save!(validate: false)
  end

  def save_education!
    education = User::Education.new(user_id: @user.id)
    education.save!(validate: false)
  end
end
