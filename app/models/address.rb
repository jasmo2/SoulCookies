
class Address
  include ActiveRecord::Serialization
  def initialize(current_customer)
    address = nil
    if current_customer.nil?
      address = Shoppe::Address.new
    else
      address = current_customer.addresses
    end
    address
  end
end