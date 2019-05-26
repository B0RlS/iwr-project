class ChangeColumnNameInProfile < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :country, :country_code
  end
end
