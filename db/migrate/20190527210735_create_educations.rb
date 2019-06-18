class CreateEducations < ActiveRecord::Migration[5.2]
  def change
    create_table :educations do |t|
      t.string :university
      t.string :faculty
      t.string :department
      t.integer :entrance_year
      t.integer :graduation_year
      t.string :english_level
    
      t.timestamps
    end
    
    add_reference :educations, :user, foreign_key: true
  end
end
