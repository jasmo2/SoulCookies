# == Schema Information
#
# Table name: shoppe_orders
#
#  id                        :integer          not null, primary key
#  token                     :string
#  first_name                :string
#  last_name                 :string
#  company                   :string
#  billing_address1          :string
#  billing_address2          :string
#  billing_address3          :string
#  billing_address4          :string
#  billing_postcode          :string
#  billing_country_id        :integer
#  email_address             :string
#  phone_number              :string
#  status                    :string
#  received_at               :datetime
#  accepted_at               :datetime
#  shipped_at                :datetime
#  created_at                :datetime
#  updated_at                :datetime
#  delivery_service_id       :integer
#  delivery_price            :decimal(8, 2)
#  delivery_cost_price       :decimal(8, 2)
#  delivery_tax_rate         :decimal(8, 2)
#  delivery_tax_amount       :decimal(8, 2)
#  accepted_by               :integer
#  shipped_by                :integer
#  consignment_number        :string
#  rejected_at               :datetime
#  rejected_by               :integer
#  ip_address                :string
#  notes                     :text
#  separate_delivery_address :boolean          default(FALSE)
#  delivery_name             :string
#  delivery_address1         :string
#  delivery_address2         :string
#  delivery_address3         :string
#  delivery_address4         :string
#  delivery_postcode         :string
#  delivery_country_id       :integer
#  amount_paid               :decimal(8, 2)    default(0.0)
#  exported                  :boolean          default(FALSE)
#  invoice_number            :string
#  customer_id               :integer
#

class OrderTracker < Shoppe::Order
  has_many :states, dependent: :destroy


end
