class AddTelephoneToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :telephone, :string
  end
end
