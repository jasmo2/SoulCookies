module Api
  class ConfirmationFactory
    include ActiveModel::Serialization

    def TypeC.factory vt
      { "express" => ConfirmationExpress,
        "customer_user" => ConfirmationCustomerUser }[vt].new
    end
  end
  class ConfirmationExpress < ConfirmationFactory
    def confirmation(current_order)
      order = Shoppe::Order.find(current_order.id)
      order.separate_delivery_address = "0"
      order.attributes = order_params
      order.attributes = {
          billing_address2: "Colombia",
          billing_address3: "Bogotá",
          billing_address4: "Bogotá D.C.",
          billing_country_id: Shoppe::Country.where(name: "Colombia").first.id,
          billing_postcode: "4-72",
          last_name: "."
      }
      order.ip_address = request.ip
      unless order.proceed_to_confirm
        render json: { "error": il18n_attributes(Shoppe::Order, order) }
        return false
      end
      true
    end
  end

  class ConfirmationCustomer < ConfirmationFactory
    def confirmation

    end
  end
end