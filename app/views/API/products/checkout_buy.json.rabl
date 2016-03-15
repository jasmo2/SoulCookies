object @ajax_current_order
attributes *Shoppe::Order.column_names
node(:added_to_basket) { 'se ah agregado tu galleta' }
node(:total_items) do |ajax_current_order|
  ajax_current_order.total_items
end
node(:total_cost) do |ajax_current_order|
  ajax_current_order.total
end
child :order_items  do
  # attributes *Shoppe::OrderItem.column_names
  attributes :quantity
  node(:full_name) do |order_item|
    order_item.ordered_item.full_name
  end
end
