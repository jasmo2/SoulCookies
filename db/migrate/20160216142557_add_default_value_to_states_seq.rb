class AddDefaultValueToStatesSeq < ActiveRecord::Migration
  def change
    change_column :states, :seq, :integer, :default => 1
  end
end
