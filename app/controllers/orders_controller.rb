class OrdersController < ApplicationController
  before_filter :address_instance, only: :checkout
  before_filter :address_all, only: :checkout
  def checkout
    @order = Shoppe::Order.find(current_order.id)
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
  end
end
