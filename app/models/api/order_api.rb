module Api
  class OrderApi
    include ActiveModel::Callbacks
    include ActiveModel::Serialization
    attr_reader :order, :order_params

    def initialize(args = {}) #, order_params
      @order = args[:order]
      @order_params = args[:order_params]
      @request_ip = args[:request_ip]
    end

    def self.successful(order_number)

    end

    def confirmation(confirmation_type)
      confirmation_obj = Api::ConfirmationFactory.factory confirmation_type
      confirmation_obj.confirmation({
                                        current_order: @order,
                                        order_params: @order_params,
                                        request_ip: @request_ip
                                    })
      @order.confirm!
      OrderMailer.delay.received_order(@order)
      OrderMailer.delay.new_order_admin(Shoppe::User.all,@order.id)
      state = State.create(order_tracker_id: @order.id)
      successful( @order.number)
    end
  end
end