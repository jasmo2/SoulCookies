module Api
  class OrdesApi
    include ActiveModel::Serialization
    attr_reader @order, @order_params

    def initialize order, order_params
      @order = order
      @order_params = order_params
    end

    def self.successful(order_number)

    end
  end

  def confirmation(confirmation_type)
    confirmation_obj = TypeC.factory confirmation_type
    # confirmation_express ? nil : return
    begin
      @order.confirm!
      OrderMailer.delay.received_order(@order)
      OrderMailer.delay.new_order_admin(Shoppe::User.all,@order.id)
      state = State.create(order_tracker_id: @order.id)
      successful( @order.number)

    rescue Shoppe::Errors::PaymentDeclined => e
      flash[:alert] = "Payment was declined by the bank. #{e.message}"
    rescue Shoppe::Errors::InsufficientStockToFulfil
      flash[:alert] = "We're terribly sorry but while you were checking out we ran out of stock of some of the items in your basket. Your basket has been updated with the maximum we can currently supply. If you wish to continue just use the button below."
    rescue Exception => e
      puts "know Error: #{e}"
      puts e
    end
  end


  def confirmation_express

  end

end