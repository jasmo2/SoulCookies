class AddFacebookToCustomers < ActiveRecord::Migration
  def change
    add_column :shoppe_customers, :provider, :string
    add_column :shoppe_customers, :uid, :string
    add_column :shoppe_customers, :name, :string
    add_column :shoppe_customers, :oauth_token, :string
    add_column :shoppe_customers, :oauth_expires_at, :datetime
  end
end
