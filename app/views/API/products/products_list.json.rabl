object @product
attributes :id, :name, :description
# attributes *ColombianProduct.column_names
node(:price_with_tax) do |product|
  product.price_with_tax
end
node(:default_image_path) do |product|
  product.default_image.path
end
node(:product_category) do |product|
  product.product_category.permalink
end
node(:product_id) do |product|
  product.permalink
end
