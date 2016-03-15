  class OrderApi
    include ActiveModel::Callbacks
    include ActiveModel::Serialization
    attr_reader :order, :order_params

    def initialize(args = {}) #, order_params
      @order = args[:order]
      @order_params = args[:order_params]
    end

    def self.successful(order_number)

    end

  def confirmation(confirmation_type)
    confirmation_obj = ConfirmationFactory.factory confirmation_type
    confirmation_obj.confirmation
    @order.confirm!
    OrderMailer.delay.received_order(@order)
    OrderMailer.delay.new_order_admin(Shoppe::User.all,@order.id)
    state = State.create(order_tracker_id: @order.id)
    successful( @order.number)
  end
end