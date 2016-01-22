class ProductsController < ApplicationController

  before_filter do
    if params[:category_id]
      @product_category = Shoppe::ProductCategory.where(:permalink => params[:category_id]).first!
    end
    if @product_category && params[:product_id]
      @product = @product_category.products.where(:permalink => params[:product_id]).active.first!
    end
  end

  def index
    @products = ColombianProduct.active.includes(:product_categories, :variants).root
  end

  def show
    @attributes = @product.product_attributes.public.to_a
  end

  def add_to_basket
    product_to_order = params[:variant] ? @product.variants.find(params[:variant].to_i) : @product
    @ajax_current_order = current_order.order_items.add_item(product_to_order, params[:quantity].to_i)
    respond_to do |wants|
      # wants.html { redirect_to request.referer }
      wants.js { render 'products/add_to_basket'}
      wants.json { render :json => {:added => true} }
    end
  rescue Shoppe::Errors::NotEnoughStock => e
    respond_to do |wants|
      wants.js { render 'products/exception_stock' }
      wants.json { render :json => {:error => 'NotEnoughStock', :available_stock => e.available_stock}}
    end
  end
end
