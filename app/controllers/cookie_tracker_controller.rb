class CookieTrackerController < ApplicationController
  def index
  end

  def search
    respond_to do |f|
      f.js do
        order = Shoppe::Order.where(id: cookies_params).first
        @order = OrderTracker.new(order)
        render 'steps'
      end
    end
  end


  private
  def cookies_params
    params.permit("cookie-number")['cookie-number'].to_s
  end
end