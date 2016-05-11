
module Api
  class ProductsController < BaseController
    before_filter :access_private , if: Proc.new{ |c|
      JSON.parse(c.request.raw_post)["confirmation_type"] == "customer_user"
    },  only: :checkout_buy

    def index
      @ajax_current_order = current_order
      @products = ColombianProduct.active.includes(:product_categories, :variants).root
    end

    def checkout_buy
      begin
        information = request.raw_post
        data = JSON.parse(information)
        products = data["products"]
        products.each do |product|
          product = product["product"]
          @product = get_api_product(product)
          raise ArgumentError if product["quantity"].to_i <= 0
          current_order.order_items.add_item(@product, product["quantity"].to_i)
          @ajax_current_order =  current_order.reload
        end
        order_api = Api::OrderApi.new({
<<<<<<< HEAD
                                          "order"=> @ajax_current_order,
                                          "order_params"=> data["order_params"],
                                          "request_ip"=> request.ip
=======
                                          "order": @ajax_current_order,
                                          "order_params": data["order_params"],
                                          "current_customer": current_customer,
                                          "request_ip": request.ip
>>>>>>> master
                                      })
        render json: { "order_id"=> order_api.confirmation(data["confirmation_type"])}, status: :accepted

      rescue Shoppe::Errors::NotEnoughStock => e
        render :json => {:error => 'NotEnoughStock', :available_stock => e.available_stock}, status: :failed_dependency
      rescue JSON::ParserError => e
        render :json => {:error => 'Bad json format' }, status: :bad_request
      rescue ArgumentError => e
        render :json => {:error => 'Al menos selecciona una galleta' }, status: :bad_request
      rescue Shoppe::Errors::PaymentDeclined => e
        render :json => {:error => 'el pago ha sido denegado' }, status: :bad_request
      rescue Shoppe::Errors::InsufficientStockToFulfil => e
        render :json => {:error => "Lo sentimos no hay más #{e} en nuestro inventario" }, status: :bad_request
      rescue Api::Exceptions::InappropriateAddress => e
        render :json => {:error => JSON.parse(eval(e.message).to_json) }, status: :bad_request
      rescue Exception => e
        render :json => {:error => "#{e}" }, status: :bad_request
      end
    end

    private
    def get_api_product (product)
      if product["product_category"]
        @product_category = Shoppe::ProductCategory.where(:permalink => product["product_category"]).first!
      end
      if @product_category && product["product_id"]
        @product = @product_category.products.where(:permalink => product["product_id"]).active.first!
      end
    end


    helper_method :get_api_product
  end


end
