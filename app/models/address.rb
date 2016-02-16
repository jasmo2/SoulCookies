
class Address
  include ActiveRecord::Serialization
  attr_reader :addresses, :address_id, :current_customer
  def initialize(current_customer, address_id = nil)
    @address_id = address_id
    if current_customer.nil?
      address = [Shoppe::Address.new]
    else
      address = current_customer.addresses
      @current_customer = current_customer
    end
    @addresses = address
  end

  def set_shoppe_address
    address = Shoppe::Address.find(@address_id)
    return {
        first_name: @current_customer.first_name,
        last_name:@current_customer.last_name,
        billing_address1: address.address1,
        billing_address2:address.address2,
        billing_address3: address.address3,
        billing_address4: address.address4,
        billing_country_id: address.country_id.to_i,
        billing_postcode: address.postcode,
        delivery_name: @current_customer.first_name,
        delivery_address1: address.address1,
        delivery_address2:  address.address2,
        delivery_address3:  address.address3,
        delivery_address4:  address.address4,
        delivery_postcode:  address.postcode,
        delivery_country_id:  address.country_id.to_i,
        email_address: @current_customer.email,
        phone_number: @current_customer.phone,
        separate_delivery_address: "0",
        customer_id: @current_customer
    }

  end
end