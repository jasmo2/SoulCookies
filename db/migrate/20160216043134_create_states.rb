class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.integer :order_tracker_id
      t.timestamps null: false
    end
  end
end
