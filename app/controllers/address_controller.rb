class AddressController < ApplicationController
  def create
    respond_to do |format|
      format.js do
        @address = Shoppe::Address.new(address_params)
        @address.attributes = {
          customer: current_customer,
          country: get_country,
          address_type: "delivery",
          default: false
        }
        if @address.save
          render "address/new"
        else
          render js: "alert('ha ocurrido un error al');", status: 400
        end
      end
    end
  end

  def new
  end

  def delete
  end

  def update
  end

  def edit
  end

  private
  def address_params
    params.require("address").permit("address1","address2","address3","address4",:"postcode")
  end
  def get_country
    Shoppe::Country.find(params.require("address").permit("country_id")["country_id"].to_i)
  end
end
