
module Api
  class ProductsController < BaseController


    def index
      @ajax_current_order = current_order
      @products = ColombianProduct.active.includes(:product_categories, :variants).root
    end

    def checkout_buy
=begin
    recieving json:
    {
      products: [
        product:{
            product_category: "product_category_permalink",
            product_id: "permalink"
            quatity: "#"
          }
      ]
    }
=end
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
        # here initialize the order
        order_api = OrderApi.new(@ajax_current_order, data["order_params"])
        order_api.confirmation(data["confirmation_type"])

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
        render :json => {:error => "La dirección provista es incorrecta" }, status: :bad_request
      rescue Exception => e
        puts "Error: #{e}"
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
