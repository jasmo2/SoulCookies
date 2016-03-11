
module Api
  class ProductsController < BaseController
    before_filter do
      if params[:category_id]
        @product_category = Shoppe::ProductCategory.where(:permalink => params[:category_id]).first!
      end
      if @product_category && params[:product_id]
        @product = @product_category.products.where(:permalink => params[:product_id]).active.first!
      end
    end
    def index
      @ajax_current_order = current_order
      @products = ColombianProduct.active.includes(:product_categories, :variants).root
    end

    def add_to_basket
      raise ArgumentError if params[:quantity].to_i <= 0
      current_order.order_items.add_item(@product, params[:quantity].to_i)
      @ajax_current_order =  current_order.reload
      render
    rescue Shoppe::Errors::NotEnoughStock => e
        render :json => {:error => 'NotEnoughStock', :available_stock => e.available_stock}
    rescue ArgumentError => e
       render :json => {:error => 'Al menos selecciona una galleta' }
    end
  end
end
