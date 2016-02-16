class AddSeqToStates < ActiveRecord::Migration
  def change
    add_column :states, :seq, :integer
  end
end
