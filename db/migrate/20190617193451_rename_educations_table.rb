class RenameEducationsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :educations, :user_educations
  end
end
