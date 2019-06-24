class CreateVacancyRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :vacancy_requests do |t|
      t.boolean :approve

      t.timestamps
    end

    add_reference :vacancy_requests, :vacancy, foreign_key: true
    add_reference :vacancy_requests, :user, foreign_key: true
  end
end
