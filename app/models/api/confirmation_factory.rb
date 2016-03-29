module Api
  class ConfirmationFactory
    include ActiveModel::Serialization
    # include Api::Exceptions::InappropriateAddress
    # include Api::I18n_m
    def ConfirmationFactory.factory vt
      { "express" => ConfirmationExpress,
        "customer_user" => ConfirmationCustomer }[vt].new
    end
  end
  class ConfirmationExpress < ConfirmationFactory
    def confirmation(agrs)
      current_order = agrs[:current_order]
      order_params = agrs[:order_params]
      request_ip = agrs[:request_ip]
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
      order.ip_address = request_ip
      unless order.proceed_to_confirm
        raise Api::Exceptions::InappropriateAddress ,  Api::Exceptions::I18n_m.new(Shoppe::Order, order).i18n_attributes
      end
      order
    end
  end

  class ConfirmationCustomer < ConfirmationFactory
    def confirmation

    end
  end
end