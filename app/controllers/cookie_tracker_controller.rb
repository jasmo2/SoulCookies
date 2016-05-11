=begin
class CookieTrackerController < ApplicationController
  def index
  end

  def search
    respond_to do |f|
      f.js do
          order = Shoppe::Order.where(id: cookies_params).first
          if order
            @order = OrderTracker.new(order)
            puts "which sequence: #{@order.state.seq}"
            render 'steps'
          else
            render js: "sweetAlert('Número de tracker invalido', 'Escriba una orden valida', 'warning');", status: 400
          end
      end
    end
  end


  private
  def cookies_params
    params.permit("cookie-number")['cookie-number'].to_s
  end
end
=end
