module Api
  class AddressController < BaseController
    before_action :access_private, only: [:create, :index,:destroy]
    before_action :address_params, only: :create


    def create
      begin
        @address = Shoppe::Address.new(address_params)
        @address.attributes = {
            customer: current_customer,
            country: get_country,
            address_type: "delivery",
            default: false
        }
        @address.save!
        render :json => {id: @address.id}, status: :ok
      rescue ActiveRecord::RecordInvalid => e
        render :json => {:error => 'Dirección no guardada'}, status: :bad_request
      rescue ActiveRecord::RecordNotSaved => e
        render :json => {:error => 'Dirección no guardada'}, status: :bad_request
      end
    end


    def destroy
    end

    private
    def address_params
      information = request.raw_post
      data = JSON.parse(information)
      # params.require("address").permit("address1","address2","address3","address4",:"postcode")
    end
    def get_country
      Shoppe::Country.find_by_name("Colombia")
    end
    def delete_address
      # @customers_user = current_customer
      # @address = Shoppe::Address.find_by_id(params[:id])
    end
  end
end
