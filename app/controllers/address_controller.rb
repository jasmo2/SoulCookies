class AddressController < ApplicationController
  before_action :delete_address, only: :destroy


  def create
    respond_to do |f|
      @address = Shoppe::Address.new(address_params)
      @address.attributes = {
        customer: current_customer,
        country: get_country,
        address_type: "delivery",
        default: false
      }
      f.js do
        if @address.save
          render "address/new"
        else
          render js: "sweetAlert('Falta una dirección', 'Por favor escribe una dirección.', 'warning');", status: 400
        end
      end
      f.html do
        if @address.save
          redirect_to controller: "customers_users", action: "edit", id: current_customer
        else
          @customers_user = current_customer
          render "customers_users/edit"
        end
      end

    end
  end

  def new
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to controller: "customers_users", action: "edit", id: current_customer ,notice: 'La dirección fue eliminada.' }
      format.json { head :no_content }
    end
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
    Shoppe::Country.find_by_id(params.require("address").permit("country_id")["country_id"].to_i)
  end
  def delete_address
    @customers_user = current_customer
    @address = Shoppe::Address.find_by_id(params[:id])
  end
end
