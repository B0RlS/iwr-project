# frozen_string_literal: true

class UserCreateService
  attr_reader :name, :surname, :email, :password, :password_confirmation

  def initialize(params)
    @name = params[:name]
    @surname = params[:surname]
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end

  def call!
    save_user!
  end

  private

  def save_user!
    User.create(name: name, surname: surname,
                email: email, password: password,
                password_confirmation: password_confirmation)
  end
end
