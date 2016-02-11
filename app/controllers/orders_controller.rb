class OrdersController < ApplicationController
  before_filter :address_instance, only: :checkout
  before_filter :address_all, only: :checkout
  before_filter :get_order, only: [:checkout,:express]

  def successful
    @order_number = params[:order_number]
    respond_to do |format|
      format.js {
        render 'successful'
      }
    end
  end

  def checkout
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
        else
          confirmation_user
        end

        redirect_to action: 'successful',
                    order_number: @order.number
      end
    end
  end

  def confirmation_express
    @order = Shoppe::Order.find(current_order.id)
    @order.attributes = params[:order].permit(:first_name, :last_name, :company, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number, :delivery_name, :delivery_address1, :delivery_address2, :delivery_address3, :delivery_address4, :delivery_postcode, :delivery_country_id, :separate_delivery_address)
    @order.last_name = "."
    @order.ip_address = request.ip
    unless @order.proceed_to_confirm
      render 'express'
      return false
    end
    true
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
  def address_instance
    @address = Shoppe::Address.new
  end
  def address_all
    @addresses = Address.new(current_customer)
    @addresses = @addresses.addresses
  end
  def get_order
    @order = Shoppe::Order.find(current_order.id)
  end
end
