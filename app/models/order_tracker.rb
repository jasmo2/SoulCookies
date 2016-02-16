
class OrderTracker < SimpleDelegator
  include ActiveModel::Callbacks
  attr_accessor :order, :state
  def initialize(obj)
    order =  __setobj__(obj)
    @state = State.where(:order_tracker_id => order.id ).first
  end

  def state
    @state
  end

end
