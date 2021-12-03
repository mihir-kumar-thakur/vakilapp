class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :name
    end

    add_index :states, :name, unique: true
  end
end
