class CreateAdvocateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :advocate_cases do |t|
      t.integer :advocate_id
      t.integer :case_id
      t.string :status
    end
  end
end
