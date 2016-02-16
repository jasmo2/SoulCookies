# == Schema Information
#
# Table name: states
#
#  id               :integer          not null, primary key
#  name             :string
#  order_tracker_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  seq              :integer
#

class State < ActiveRecord::Base
  belongs_to :shoppe_order
  after_commit :begin_tracker, :on => :create
  def increment_seq
    seq = self.seq
    if seq < 5
      self.seq = seq + 1
      self.save!
    end
  end
  def begin_tracker
    CookieTrackerJob.perform_now(self)
  end
end
