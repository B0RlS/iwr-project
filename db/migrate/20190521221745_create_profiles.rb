# frozen_string_literal: true

# Profile db class
class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :country
      t.string :city
      t.date :birthday

      t.timestamps
    end
  end
end
