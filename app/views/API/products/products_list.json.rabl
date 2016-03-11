object @product
attributes :id, :name, :description
# attributes *ColombianProduct.column_names
node(:price_with_tax) do |product|
  product.price_with_tax
  end
node(:default_image_path) do |product|
  product.default_image.path
end
node(:buy_product_path) do |product|
  "products/#{product.product_category.permalink}/#{product.permalink}/buy"
end
