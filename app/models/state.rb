# == Schema Information
#
# Table name: states
#
#  id               :integer          not null, primary key
#  name             :string
#  order_tracker_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  seq              :integer          default(0)
#

class State < ActiveRecord::Base
  validates_uniqueness_of :order_tracker_id
  belongs_to :shoppe_order
  # after_commit :begin_tracker, :on => :create
  def increment_seq
    seq = self.seq
    if seq < 4
      self.seq = seq + 1
      self.save!
    end
  end
  def begin_tracker
    #Fixme seq begins in 5...

  end
end
