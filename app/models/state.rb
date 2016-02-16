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
  belongs_to :order_tracker
  
end
