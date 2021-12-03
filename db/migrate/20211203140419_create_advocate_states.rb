class CreateAdvocateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :advocate_states do |t|
      t.integer :advocate_id
      t.integer :state_id
    end
  end
end
