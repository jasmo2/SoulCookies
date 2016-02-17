class AddPasswordResetToShopperCustomers < ActiveRecord::Migration
  def change
    add_column :shoppe_customers, :password_reset_token, :string
    add_column :shoppe_customers, :password_reset_sent_at, :datetime
  end
end
