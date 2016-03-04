class OrdersController < ApplicationController
  before_filter :address_instance, only: :checkout
  before_filter :address_all, only: :checkout
  before_filter :get_order, only: [:checkout,:express]

  before_filter { redirect_to root_path unless has_order? }

  def index
    respond_to do |f|
      f.js {
        render
      }
    end
  end

  def successful
    @order_number = params[:order_number]
    respond_to do |f|
      f.js {
        @order = nil
        session[:order_id] = nil
        render 'successful'
      }
    end
  end

  def checkout
    # minimum order
    if current_order.nil? && current_order.order_items.count >= 3
      render
    else
      flash[:alert] =  "Lo sentimos  , nuestro pedido minimo es de 3 galletas"
      redirect_to root_path
    end
  end

  def express
    respond_to do |format|
      format.js do
        render
      end
    end
  end

  def change_item_quantity
    item = current_order.order_items.find(params[:order_item_id])
    request.delete? ? item.decrease! : item.increase!
    respond_to do |wants|
      wants.html { redirect_to request.referer || root_path, :notice => "Quantity has been updated successfully." }
      wants.json do
        current_order.reload
        if current_order.empty?
          destroy
        else
          render :json => {:status => 'complete', :items => render_to_string(:partial => 'shared/order_items.html', :locals => {:order => current_order})}
        end
      end
    end
  rescue Shoppe::Errors::NotEnoughStock => e
    respond_to do |wants|
      wants.html { redirect_to request.referer, :alert => "Unfortunately, we don't have enough stock. We only have #{e.available_stock} items available at the moment. Please get in touch though, we're always receiving new stock." }
      wants.json { render :json => {:status => 'error', :message => "Unfortunateley, we don't have enough stock to add more items."} }
    end
  end

  def remove_item
    item = current_order.order_items.find(params[:order_item_id])
    if current_order.order_items.count == 1
      destroy
    else
      item.remove
      respond_to do |wants|
        wants.html { redirect_to request.referer, :notice => "Item has been removed from your basket successfully"}
        wants.json do
          current_order.reload
          render :json => {:status => 'complete', :items => render_to_string(:partial => 'shared/order_items.html', :locals => {:order => current_order})}
        end
      end
    end
  end

  def confirmation
    respond_to do |format|
      format.js do
        if request.patch?
          confirmation_express ? nil : return
        end

      end
      format.json do
        confirmation_customer_user
        # render :nothing => true
      end
    end
    begin
      @order.confirm!
      OrderMailer.delay.received_order(@order)
      OrderMailer.delay.new_order_admin(Shoppe::User.all,@order.id)
      state = State.create(order_tracker_id: @order.id)
      redirect_to action: 'successful',
                  order_number: @order.number

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
    @order = Shoppe::Order.find(current_order.id)
    @order.separate_delivery_address = "0"
    @order.attributes = params[:order].permit(:first_name, :last_name, :email_address, :phone_number,:billing_address1, )
    @order.attributes = {
         billing_address2: "Colombia",
         billing_address3: "Bogotá",
         billing_address4: "Bogotá D.C.",
         billing_country_id: Shoppe::Country.where(name: "Colombia").first.id,
         billing_postcode: "4-72",
         last_name: "."
    }
    @order.ip_address = request.ip
    unless @order.proceed_to_confirm
      render 'express'
      return false
    end
    true
  end

  def confirmation_customer_user
    @order = Shoppe::Order.find(current_order.id)
    @order.delivery_service = Shoppe::DeliveryService.first
    @order.save
    address = Address.new(current_customer, params_confirmation_customer["direction"])
    @order.attributes = address.set_shoppe_address
    @order.ip_address = request.ip

    @order.proceed_to_confirm

    @order
  end

  def destroy
    current_order.destroy
    session[:order_id] = nil
    respond_to do |wants|
      wants.html { redirect_to root_path, :notice => "Your basket has been emptied successfully."}
      wants.json do
        flash[:notice] = "Your shopping bag is now empty."
        render :json => {:status => 'complete', :redirect => root_path}
      end
    end
  end

  private

  def address_all
    @addresses = Address.new(current_customer)
    @addresses = @addresses.addresses
  end
  def get_order
    @order = Shoppe::Order.find(current_order.id)
    end
  def params_confirmation_customer
    params.require("confirmation").permit("direction","customer")
  end
end
