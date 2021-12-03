class CreateAdvocates < ActiveRecord::Migration[6.1]
  def change
    create_table :advocates do |t|
      t.string :code
      t.string :position
      t.integer :senior_id
    end

    add_index :advocates, :code, unique: true
  end
end
