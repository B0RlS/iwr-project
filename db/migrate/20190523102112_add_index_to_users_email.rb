# frozen_string_literal: true

# Add index to USer
class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
  end
end
