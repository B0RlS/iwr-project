# frozen_string_literal: true

# User db class
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.integer :profile_id
      t.integer :role_id

      t.timestamps
    end
  end
end
