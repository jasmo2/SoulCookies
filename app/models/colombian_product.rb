# == Schema Information
#
# Table name: shoppe_products
#
#  id                :integer          not null, primary key
#  parent_id         :integer
#  name              :string
#  sku               :string
#  permalink         :string
#  description       :text
#  short_description :text
#  active            :boolean          default(TRUE)
#  weight            :decimal(8, 3)    default(0.0)
#  price             :decimal(8, 2)    default(0.0)
#  cost_price        :decimal(8, 2)    default(0.0)
#  tax_rate_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#  featured          :boolean          default(FALSE)
#  in_the_box        :text
#  stock_control     :boolean          default(TRUE)
#  default           :boolean          default(FALSE)
#

class ColombianProduct <  Shoppe::Product
  def price_with_tax
    self.price * tax_display
  end
  private
  def tax_display
    tax_display = 0
    if self.tax_rate.nil?
      tax_display = 0
    else
      tax_display = self.tax_rate.rate
    end
    (1 + (tax_display)/100)
  end
end
