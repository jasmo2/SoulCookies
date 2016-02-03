class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Returns the active order for this session
  protected
  def current_customer
    session_customer= session[:user_customer_id]
    @current_user ||= CustomersUser.where('id = ? or uid = ?',session_customer,session_customer.to_s).first if session[:user_customer_id] && !session[:user_customer_id].nil?
  end
  def current_order
    @current_order ||= begin
      if has_order?
        @current_order
      else
        order = Shoppe::Order.create(:ip_address => request.ip)
        session[:order_id] = order.id
        order
      end
    end
  end

  def has_order?
    !!(
    session[:order_id] &&
        @current_order = Shoppe::Order.includes(:order_items => :ordered_item).find_by_id(session[:order_id])
    )
  end

  helper_method :current_order, :has_order?,:current_customer

end
