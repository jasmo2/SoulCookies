class ChangeDefaultValueToStatesSeq < ActiveRecord::Migration
  def change
    change_column :states, :seq, :integer, :default => 0
  end
end
