class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|
      t.string :case_code
      t.integer :state_id
    end

    add_index :cases, :case_code, unique: true
  end
end
